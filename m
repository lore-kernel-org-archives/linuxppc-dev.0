Date: Mon, 28 Feb 2000 17:57:26 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iMac Mouse Three Button Emulation: a solution
In-Reply-To: <38BA9C94.14977454@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10002281754130.24776-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Please note that you should NOT activate this feature if you have a working
> three-button USB mouse, as the code blocks any 2nd and 3rd mouse button events
> and passes the emulated ones only. This behaviour is not nice, but I must
> admit that I can not imagine a situation where this is really a problem, so I
> omitted the code to fix this. An other point: the emulation does of course not

It's a simple matter of keeping track of the button states, OR'ing
emulated and real buttons together. But it's a bit pointless indeed :-)

> work if you do not have an USB keyboard, e.g. if you connect the iMac Mouse to
> a Lombard PowerBook.

In which case the ADB button emulation works just fine, via the builtin
ADB trackpad ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
