Message-ID: <20000327024715.28938.qmail@www0l.netaddress.usa.net>
Date: 26 Mar 00 19:47:15 MST
From: Robert Shaw <rshawppc@netscape.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: PCI address collisions on 2.3.x kernels?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying for over a week now to compile the 2.3.x series kernel on my
B&W G3 machine. Everytime I get this annoying "PCI address collision" error
right at the start (after the penguin graphic appears). It goes past this and
behaves like it's booting ok, but then it tries to access the IDE buses and
fails to find anything and I get the infamous "Rebooting in 180 seconds..."
message.

Can someone please help!! I'm stumped as to why this is happening. Has anyone
else seen this? I don't think its a config problem, as I'm using the same
settings I always have that work for the latest 2.2.15pre14 kernel in the
stable tree.

I think if I can get rid of the "PCI address collision" errors, that my IDE
bus will get recognized properly.

Any ideas? Please!

TIA.


-Robert
 mailto:rshaw@linuxppc.org
 icq:45688313
 http://www.linuxppc.org/BlueG3/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
