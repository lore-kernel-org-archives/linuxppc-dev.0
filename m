From: Benjamin Herrenschmidt <bh40@calva.net>
To: <leberre@convergence.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pismo + sound
Date: Thu, 11 May 2000 16:08:21 +0200
Message-Id: <20000511140823.21457@mailhost.mipsys.com>
In-Reply-To: <20000507202020.A16934@warez.convergence.de>
References: <20000507202020.A16934@warez.convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 7, 2000, leberre@convergence.de <leberre@convergence.de> wrote:

>
>I would like to try to get the sound chip of the pismo running,
>but I have no idea about the way to activate it.
>Benjamin Herrenschmidt said for 2 month that it was the same as the one
>on G4 (awacs/screamer on davbus). What precisely has to be done to get it
>run? I really would like
>to try doing this.

There are several things that can be tried. The AWACS revision used in
the Pismo is one of the more recent "screamer" revisions and has more
registers than actually handled by the Linux driver. It's possible that
some of those need different initialisations.

Another possibility is that the sound chip may need to be explicitely
powered up (or the amplifier). Did you try the sound out jack ? Does it
work ? If it works, then only the speakers amplifiers need to be powered
up. The way to do that is usually to spend hours disassembling bits of
MacOS until you find what magic bits must be turned on (usually in the
feature controller of the mac-io chip).

Unfortunately, the latest darwin kernel source I have don't have specific
code for the Pismo.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
