MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14952.48929.34769.196323@chiark.greenend.org.uk>
Date: Fri, 19 Jan 2001 22:26:41 +0000 (GMT)
From: Chris Emerson <cemerson@chiark.greenend.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <19341214104258.22601@mailhost.mipsys.com>
References: <3A686DFE.9030308@valinux.com>
	<19341214104258.22601@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[dri-devel removed]

On Friday, 19 Jan 2001, Benjamin Herrenschmidt wrote:

[requirements for prom_print() and xmon_printf()]
[snip]
>  - The same video mode/depth current than the one you had when it
> booted.

Does that mean the mode/depth set by OF, or the one set by the vmode
kernel cmdline option?

> If you are using an fbdev, the recent aty128fb should properly "update"
> the screen informations of the early boot text engine on a mode switch.

Ok.

> When debugging kernel code on a G4 mac, the best thing to do is to have a
> stealth serial port.

Is it possible to use xmon on a G4 (350MHz AGP) without one of these
stealth serial ports?  I don't currently do enough kernel debugging to
really make it worth getting one along with the necessary cables to
plug something into it.

I'm currently running 2.4.1pre7 rsynced from the bk tree.

Cheers,

Chris
--
Chris Emerson, obsessed Cambridge juggler
E-mail: cemerson@chiark.greenend.org.uk
Web page: http://www.chiark.greenend.org.uk/~cemerson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
