From: kd@flaga.is
Subject: Re: Detecting keyboard event (input) for non X application
To: abz@videotron.ca
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFAD4C5102.EA44A7BA-ON002568EB.004D980C@flaga.is>
Date: Fri, 26 May 2000 14:09:04 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What about using poll() with timeout and then read() to get the keyboard
data?

K.D.

Alain Birtz wrote:


Within an infinite loop, how to know if there is a keyboard input ?
Is there something similar to XNextEvent for non X application ?

getchar do not work since it stop and wait for the next keyboard event.
What I need is a function that I can call periodically to know if there
is a keyboard input.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
