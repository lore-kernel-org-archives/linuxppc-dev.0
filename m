Message-ID: <3A5B5604.36EF3E2E@mvista.com>
Date: Tue, 09 Jan 2001 13:18:44 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: menuconfig for PPC860T
References: <Pine.GSO.4.21.0101090955400.18580-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> For about the last week, make xconfig has stopped working for the
> EST8260 board in the 2.5 bk tree.  It dies with:
>
> make[1]: Entering directory `/home/ford/linux/src/linuxppc_2_5/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/ppc/config.in >> kconfig.tk
> statement not in menu
> make[1]: *** [kconfig.tk] Error 1


Aside from this, I don't think anything but the manual 'make config' has
ever worked for the 8260.  The problem is I set two processor type
configuration variables, CONFIG_6xx and CONFIG_8260.  Most of the
scripts try to be "smart" and only allow one to be set.  I know
'make menuconfig' doesn't work properly, I suspect 'make xconfig'
does the same (unless Tom has fixed this recently :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
