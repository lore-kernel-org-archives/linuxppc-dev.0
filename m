Message-ID: <3C068573.52E5AF0E@mvista.com>
Date: Thu, 29 Nov 2001 10:58:59 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
References: <15365.51839.327359.844495@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> I have looked at all the different ide_init_hwif_ports implementations
> in the linuxppc_2_4_devel tree.
> So I am proposing to drop ppc_md.ide_init_hwif_ports and change the
> definition of ide_init_hwif_ports in include/asm-ppc/ide.h to the one
> above.
>
> Comments?
>

works for  me.

---armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
