Message-ID: <003f01c3ec29$517014e0$0402a8c0@server>
From: "Joseph Bennie" <jay@lincore.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: nvidia framebuffer and broken pttys on G4 powerbook
Date: Thu, 5 Feb 2004 20:47:49 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What is the current solution to getting a working display on a 1Ghz G4
powerbook using the nvidia GeForce4 440 Go chip.

X =4.3
kernel =2.6.2

using the openfirmwarefb works for console, but using fbdev in X has limited
and badly mapped colors. (bpp=4 )

rivafb appears to be broken or incompatible - display just blanks after
initial boot
nvidia also dont appear to supply a ppclinux driver library :( - unless
someone knows better

Thanks in advance for any help. including pointers on where to start
contributing to the solution.
as this lump of tin cost me over 1700ukp and its of no use to me if i can
get X to work. (i think i finally found my itch )

PS - also noticed that there is a problem allocating pttys with 2.6.2

 Jay Bennie
 jay@lincore.co.uk


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
