Date: Fri, 26 May 2000 09:46:26 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: Detecting keyboard event (input) for non X application
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <392E8032.F5FFE56@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Within an infinite loop, how to know if there is a keyboard input ?
Is there something similar to XNextEvent for non X application ?

getchar do not work since it stop and wait for the next keyboard event.
What I need is a function that I can call periodically to know if there
is a keyboard input.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
