Message-ID: <3AA6F418.B1CB215C@mvista.com>
Date: Wed, 07 Mar 2001 21:53:12 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: Wolfgang Denk <wd@denx.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: "unhandled relocation type 18" ???
References: <Your message of "Tue, 06 Mar 2001 08:25:41 +0100." <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg> <5.0.2.1.2.20010306110653.02979ea8@mail.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> 18 is a PLTREL24 relocation, so a b/bl has to be involved, but it should be
> a REL24 relocation, the PLT usage points to compilation of a module with
> -fpic/-fPIC?

Heh, heh....it's probably looking for C library or compiler run-time
support (and virtual addresses to match :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
