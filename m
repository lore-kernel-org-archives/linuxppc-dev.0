To: "Dennis Khoo" <dkhoo@atmxdsl.com>
Cc: "RamanaYV" <venkataramana_y@mic.co.in>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBOOT in customised MPC860T board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Feb 2004 11:09:24 PST."
             <000001c3f71c$1372ee30$7ec7c7c7@dkhoo>
Date: Thu, 19 Feb 2004 20:48:29 +0100
Message-Id: <20040219194834.9C782C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000001c3f71c$1372ee30$7ec7c7c7@dkhoo> you wrote:
>
> Perhaps you should try the u-boot forum and use pick a tqm board as your
> guide for the u-boot port.  But briefly for u-boot port:

The TQM may be a good choice for a model, or may be not. It  dopeneds
onthe hardware. It is not possible to give a general recommendation.

> 1. Change Makefile to use your cross compiler and add your board config

No  such  change  is  necessary  nor  encouraged.  Just  export   the
CROSS_COMPILE envrionment variable as needed.

> 4. Create the include/asm/yourboard.h   Not much to do here basically
> #define IMAP_ADDR/SIZE to get the board going. (look at tqm board for
> guidance)

Don't forget to make sure to use the correct definition of bd_info.

> the options.  To save time, right after I do a "make menuconfig" and the
> .config
> file is generated in the top directory, I copy the .config file and replace
> arch/ppc/defconfig with it.

A  much  better  and  less  intrusive  way  is  to  copy  .config  to
arch/ppc/configs/<boardname>_defconfig  so  you  can use the standard
"make <boardname>_config ; make oldconfig ; make dep ;  make  uImage"
command sequence.


Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Don't try to outweird me, three-eyes. I get stranger things than you
free with my breakfast cereal."
           - Zaphod Beeblebrox in  "Hitchhiker's Guide to the Galaxy"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
