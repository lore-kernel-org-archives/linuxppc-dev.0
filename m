Date: Sun, 16 May 1999 18:06:39 +0200
From: "Jens Ch. Restemeier" <jenschrr@uni-bielefeld.de>
Subject: ATI TV on pmac
To: linuxppc-dev@lists.linuxppc.org
Reply-to: jenschrr@uni-bielefeld.de
Message-id: <373EED0D.446A@post.uni-bielefeld.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

Some guys have hacked the TV interface to ATI cards:
http://www.core.binghamton.edu/~insomnia/gatos/

Has anyone looked what it takes to port it to Linux/PPC ? My 5500's TV
is based on Mach 64, and the TV stuff (tuner, scaler, videotext) is
connected to cuda's I2C. 
My problem is currently, that the pci scanning code doesn't compile, and
it's a heap of spagetti code I don't want to hack through.

Jens


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
