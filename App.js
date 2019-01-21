import React from 'react'
import {
  AragonApp,
  Button,
  Text,

  observe
} from '@aragon/ui'
import Aragon, { providers } from '@aragon/client'
import styled from 'styled-components'

const AppContainer = styled(AragonApp)`
  display: flex;
  align-items: center;
  justify-content: center;
`

export default class App extends React.Component {
  render () {
    return (
      <AppContainer>
        <div>
          <ObservedCount observable={this.props.observable} />
          <Button onClick={() => this.props.app.JoinRide(1)}>Join</Button>
          <Button onClick={() => this.props.app.rideStart(1)}>Start</Button>
          <Button onClick={() => this.props.app.rideFinish(1)}>Finish</Button>
        </div>
      </AppContainer>
    )
  }
}

//I think that this calls from script where there is a listener from the .sol file
const ObservedCount = observe(
  (state$) => state$,
  { count: 0 }
)(
  ({ count }) => <Text.Block style={{ textAlign: 'center' }} size='xxlarge'>{count}</Text.Block>
)
