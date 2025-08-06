pragma solidity ^0.8.0;

contract RealTimeDataPipelineSimulator {
    // Data model for a single data point
    struct DataPoint {
        uint256 timestamp;
        string dataType;
        string value;
    }

    // Data model for a pipeline
    struct Pipeline {
        string name;
        address[] sources;
        address[] sinks;
        DataPoint[] dataPoints;
    }

    // Mapping of pipeline names to pipeline objects
    mapping(string => Pipeline) public pipelines;

    // Event emitted when a new data point is added to a pipeline
    event NewDataPointAdded(string pipelineName, DataPoint dataPoint);

    // Function to add a new pipeline
    function addPipeline(string memory _name, address[] memory _sources, address[] memory _sinks) public {
        pipelines[_name] = Pipeline(_name, _sources, _sinks, new DataPoint[](0));
    }

    // Function to add a new data point to a pipeline
    function addDataPoint(string memory _pipelineName, uint256 _timestamp, string memory _dataType, string memory _value) public {
        Pipeline storage pipeline = pipelines[_pipelineName];
        pipeline.dataPoints.push(DataPoint(_timestamp, _dataType, _value));
        emit NewDataPointAdded(_pipelineName, DataPoint(_timestamp, _dataType, _value));
    }

    // Function to get the data points for a pipeline
    function getDataPoints(string memory _pipelineName) public view returns (DataPoint[] memory) {
        return pipelines[_pipelineName].dataPoints;
    }
}