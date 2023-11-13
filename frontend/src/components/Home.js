import React, { useContext, useState } from 'react';
import axios from 'axios';
import { useHistory } from 'react-router-dom';
import UserContext from '../context/UserContext';
import ChessBG from '../assets/chess_bg_1.jpg';
const { SERVER_URL } = require('./Utils/Config');

  

function Home() {
    const history = useHistory();
    const User = useContext(UserContext);
   

    const handleFriendsGame = async () => {
        // create the game and also pass the starting fen position of chess.
        const res = await axios.post(`${SERVER_URL }/g/create`, { id: User.user.id, fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' });
        history.push(`/g/${res.data.gameId}`);
    }
    

    const RandomOpponentJoin = async () => {
        try {
          const res = await axios.post(`${SERVER_URL}/g/join-random`, { id: User.user.id, fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' });
          history.push(`/g/${res.data.gameId}`);
        } catch (error) {
          if (error.response && error.response.status === 404) {
            // Handle the 404 error
            try {
            const res = await axios.post(`${SERVER_URL }/g/gen-random`, { id: User.user.id, fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' });
            history.push(`/g/${res.data.gameId}`);
            } catch (error) {
              console.error(error);
            }
          } else {
            // Handle other errors
            console.error(error);
          }
        }
      };

    const handleComputerGame = async () => {
        history.push(`/g/computer`);
    }
    
    const [inputValue, setInputValue] = useState('');

    const handleInputChange = (event) => {
    setInputValue(event.target.value);
        };
    const handleSubmit = () => {
     // replace client url here with external url for front ends in kuberenets
    const url = `/g/${inputValue}`;
        
    // Redirect the user to the constructed URL
    window.location.href = url;
          };

    return (
        <div id="home-page-container" style={{backgroundImage: `url(${ChessBG})`}}>
            <div id="home-left-side">
                <div id="home-left-button">
                    <button type="submit" onClick={handleFriendsGame} className="btn btn-primary btn-lg play-game-button">Create Room</button>
                </div>
                <div id="home-left-button-join">
                    <button type="submit" onClick={handleSubmit} className="btn btn-secondary btn-lg">Join Room</button>
                    <input type="text" value={inputValue} onChange={handleInputChange} placeholder="Enter a value" className="input-box-joingame" />
                </div>
            </div>
            <div id="vertical-line"></div>
            <div id="home-right-side">
                <div id="home-right-button">
                    <button type="submit" onClick={handleComputerGame} className="btn btn-primary btn-lg play-game-button">Play against Computer</button>
                </div>
                <div id="home-right-button">
                    <button type="submit" onClick={RandomOpponentJoin} className="btn btn-primary btn-lg play-game-button">Random opponent</button>
                </div>
            </div>
        </div>
    )
}

export default Home
