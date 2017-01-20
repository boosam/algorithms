var React = require('react');

class DefaultLayout extends React.Component {
  render() {
    return (
      <html>
        <head>
          <title>{this.props.title}</title>
        </head>
        <body>
          {this.props.children}
        </body>
      </html>
    );
  }
}

DefaultLayout.propTypes = {
  title: React.PropTypes.string
}

module.exports = DefaultLayout;
