var React = require('react');
var DefaultLayout = require('./layout');

class Label extends React.Component {
  render() {
    return (<h1>{this.props.headline}</h1>);
  }
};

class BodyContent extends React.Component {
  render() {
    const { settings } = this.props
    let sum = settings && settings.sum || '';

    console.log("data: ", sum);

    return (
      <DefaultLayout title={this.props.title}>
        <Label {...this.props} />
        <strong>Random Search</strong>
        <div>output:</div>
        <div>{sum}</div>
      </DefaultLayout>
    );
  }
}

module.exports = BodyContent;
