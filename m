Message-Id: <199912020507.VAA19020@scaup.prod.itd.earthlink.net>
Date: Thu, 02 Dec 1999 05:07:54 GMT
From: jingai <jingai@earthlink.net>
To: linuxppc-dev@lists.linuxppc.org
CC: linuxppc-user@lists.linuxppc.org
Subject: ppp not working w/ kernel 2.3.29
Reply-To: jingai@earthlink.net
MIME-Version: 1.0
Content-Type: text/plain; charset="iso8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Well, I've finally got a 2.3 kernel up and running, and thanks to Ira, my USB
mouse now works as well.  But, I've got one last problem:  ppp isn't working. 
pppd claims that I don't have kernel support for PPP, but it is definitely compiled
in (or, at least, it is enabled in the .config file).

Has anyone else experienced this?  Do I need to update pppd perhaps?  Or is
there just a specific combination of (possibly unrelated) options that need to be
enabled for PPP to work in 2.3.29 (Paul's unstable tree)?

Any help is greatly appreciated,
Jonathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
