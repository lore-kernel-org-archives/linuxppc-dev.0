To: Sylvain Munaut <tnt@246tNt.com>
Cc: Gerhard Jaeger <g.jaeger@sysgo.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel Memory map on PPC / MPC5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Mar 2004 12:50:43 +0100."
             <404C5E13.9000700@246tNt.com>
Date: Mon, 08 Mar 2004 15:11:24 +0100
Message-Id: <20040308141129.F0058C10B8@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <404C5E13.9000700@246tNt.com> you wrote:
>
> But talking about this, I see in mpc5xxx_common
...
>         io_block_mapping(0x40000000, 0x40000000, 0x10000000, _PAGE_IO);
>         io_block_mapping(0x50000000, 0x50000000, 0x01000000, _PAGE_IO);
>         io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
>         io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
> }
...
> But then, what are the 3 other mappings ?

See the U-Boot sources ("include/configs/IceCube.h").

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How long does it take a  DEC  field  service  engineer  to  change  a
lightbulb?       It depends on how many bad ones he brought with him.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
