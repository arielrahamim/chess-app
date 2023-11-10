import axios from 'axios';
import { useEffect } from 'react';
import { useParams, useHistory } from 'react-router-dom';
const { SERVER_URL } = require('../Utils/Config');

function ConfirmationPage() {
  const { token } = useParams();
  const history = useHistory();

  useEffect(() => {
    async function fetchConfirmation() {
      try {
        const response = await axios.get(`${SERVER_URL}/u/confirmation/${token}`);
        const redirectUrl = response.data.redirectUrl;
        console.log(redirectUrl)

        // Redirect to the specified URL
        window.location.href =redirectUrl;
      } catch (error) {
        // Handle error if needed
      }
    }

    fetchConfirmation();
  }, [token, history]);

  return null;
}

export default ConfirmationPage;
