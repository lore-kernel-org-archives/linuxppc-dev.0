To: erik.teose@exgate.tek.com
Cc: ElTopo@myrealbox.com, linuxppc-embedded@lists.linuxppc.org,
	erik.teose@tek.com
Subject: Re: ppcboot 2.0.0 + ppclinux2.4.devel, network weirdo 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Apr 2003 09:23:14 PDT."
             <BA0E4392AD99D040885C414D992C24BE03615100@us-bv-m11>
Date: Wed, 09 Apr 2003 23:14:29 +0200
Message-Id: <20030409211434.97C20C5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BA0E4392AD99D040885C414D992C24BE03615100@us-bv-m11> you wrote:
>
> Are you using kernel code supplied by MontaVista (MV)? I had the same
> problem;
> we are using MontaVista 3.0 for the Ebony board, and I had trouble with
> the interface from u-boot 0.2.0 to the MV kernel. The MV code is very
> specific to the bootrom supplied by IBM; that bootrom is "custom" to each
> unique Ebony board, because the 2 MAC addresses are stored at the end of the
> bootrom (that's the "VPD" area). I had to modify 3 MV files to get the MAC
> address passed in from u-boot to be used by the MV kernel
> (kernel/arch/ppc/platforms/ebony.c,
> kernel/include/asm-ppc/ibm440.h, and kernel/include/asm-ppc/ibm4xx.h). I
> have attached
> my patches for these files.

You have always the option to completely ignore such dfaults and  use
the  mechanisms  available  in  U-Boot,  for example just storing the
addresses in U-Boot environment variables (like  95%  of  all  boards
do).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1000 pains                                              = 1 Megahertz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
