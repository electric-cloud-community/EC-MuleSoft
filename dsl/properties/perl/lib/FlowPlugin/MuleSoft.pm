package FlowPlugin::MuleSoft;
use JSON;
use strict;
use warnings;
use base qw/FlowPDF/;
use FlowPDF::Log;

# Feel free to use new libraries here, e.g. use File::Temp;

# Service function that is being used to set some metadata for a plugin.
sub pluginInfo {
    return {
        pluginName          => '@PLUGIN_KEY@',
        pluginVersion       => '@PLUGIN_VERSION@',
        configFields        => ['config'],
        configLocations     => ['ec_plugin_cfgs'],
        defaultConfigValues => {}
    };
}

# Auto-generated method for the procedure Create Application/Create Application
# Add your code into this method and it will be called when step runs
# Parameter: config
# Parameter: domain
# Parameter: muleVersion
# Parameter: region
# Parameter: workers
# Parameter: workerType
# Parameter: persistentQueues
# Parameter: multitenanted
# Parameter: vpnEnabled
# Parameter: monitoringAutoRestart
# Parameter: environmentID
sub createApplication {
    my ($pluginObject) = @_;

    my $context = $pluginObject->getContext();
    my $params = $context->getRuntimeParameters();

    my $ECMuleSoftRESTClient = $pluginObject->getECMuleSoftRESTClient;
    # If you have changed your parameters in the procedure declaration, add/remove them here
    my %restParams = (
        'username' => $params->{'username'},
        'domain' => $params->{'domain'},
        'muleVersion' => $params->{'muleVersion'},
        'region' => $params->{'region'},
        'workers' => $params->{'workers'},
        'workerType' => $params->{'workerType'},
        'persistentQueues' => $params->{'persistentQueues'},
        'multitenanted' => $params->{'multitenanted'},
        'vpnEnabled' => $params->{'vpnEnabled'},
        'monitoringAutoRestart' => $params->{'monitoringAutoRestart'},
        'environmentID' => $params->{'environmentID'},
    );
    my $response = $ECMuleSoftRESTClient->getAccessToken(%restParams);
    my $application = eval {
        $ECMuleSoftRESTClient->getApplication(%restParams);
    };
    
    if (!$application) {
        $response = $ECMuleSoftRESTClient->createApplication(%restParams);
        logInfo("Got response from the server: ", $response);
    } else {
        logInfo("Application " . $params->{'domain'} . " already exists, skip creating.");
        $response = $application;
    }

    my $stepResult = $context->newStepResult;

    $stepResult->setOutputParameter('restResult', encode_json($response));
    
    $stepResult->apply();
}

# This method is used to access auto-generated REST client.
sub getECMuleSoftRESTClient {
    my ($self) = @_;

    my $context = $self->getContext();
    my $config = $context->getRuntimeParameters();
    require FlowPlugin::ECMuleSoftRESTClient;
    my $client = FlowPlugin::ECMuleSoftRESTClient->createFromConfig($config);
    return $client;
}
## === step ends ===
# Please do not remove the marker above, it is used to place new procedures into this file.


1;