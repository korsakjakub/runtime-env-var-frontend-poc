import { useState } from 'react'
import './App.css'
import Config from './config.json'

function App() {
  const [count, setCount] = useState(0)
  const env = Config.ENV;
  const api = Config.API_URL;

  return (
    <>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>
      <p>ENV: {env}</p>
      <p>API: {api}</p>
    </>
  )
}

export default App
