Message-ID: <3C0CFDE7.D7950AF6@laposte.net>
Date: Tue, 04 Dec 2001 17:46:31 +0100
From: Phil <ibm405.linux@laposte.net>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matt Porter <mporter@mvista.com>,
	Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com> <3C0CD3C6.ECB0E61B@laposte.net> <20011204141147.GD17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0CDCB1.9F3A9423@laposte.net> <20011204144532.GF17651@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini a écrit :
>
> On Tue, Dec 04, 2001 at 03:24:49PM +0100, Phil wrote:
>
> > I resync the kernel sources today at 7:15 am GMT.
> > Any idea ?
>
> Have you run a 'make distclean' anytime recently?  If not, try that..
> (and save your .config someplace).
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

Yes, i have. I also try to launch it with an empty command line
as described in a previous e-mail but without success.
Are the printed adresses by the bootloader correct :
Thanks.
-Phil


Entry point at 0x500000
...

loaded at:     00500000
0058388C
relocated to:  00400000
0048388C
board data at: 004807BC
004807FC
relocated to:  0048077C
004807BC
zimage at:     00405400
0047FF59
avail ram:     00484000
02000000

Linux/PPC load: root=/dev/nfs rw
ip=auto
Uncompressing
Linux...done.
Now booting the kernel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
