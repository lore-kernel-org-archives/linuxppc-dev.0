From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E57860290F93F@ap-bang-m02.india.tek.com>
To: jbeisert@eurodsn.de, linuxppc-embedded@lists.linuxppc.org
Subject: RE: dummy_con
Date: Tue, 16 Dec 2003 04:45:36 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!!

First and foremost.... THANKS a MILLION for your response.

I did what you suggested and got an error while building.(error message
attached below) I am not sure how I should be proceeding.

Like I said before I have a S3 ViRGE/GX card. Since I did not find ViRGE/GX
in the menuconfig, I enabled S3 Trio. Do you think there is any chance of
this working ?

I searched up the net for similar error conditions...
http://lists.terrasoftsolutions.com/yellowdog-general/July01/0930.html
For them the simple solution was to unselect S3 Trio in menuconfig. It cant
apply in my case right. Now what do I do ???

Any leads on how to proceed are deeply appreciated.

Thanks in advance.

- S u d e e p    V
If at first you dont succeed, skydiving is not for you.





-----Original Message-----
From: Juergen Beisert [mailto:jbeisert@eurodsn.de]
Sent: Monday, December 15, 2003 9:03 PM
To: Sudeep, V
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dummy_con


Hi!

> THE PROBLEM:  While compiling the kernel I get the following error.
> arch/ppc/kernel/kernel.o: In function `ppc4xx_setup_arch':
> arch/ppc/kernel/kernel.o(.text.init+0xbee): undefined reference to
> `dummy_con'
> arch/ppc/kernel/kernel.o(.text.init+0xbf2): undefined reference to
> `dummy_con'
> arch/ppc/kernel/kernel.o(.text.init+0xbf6): undefined reference to
> `conswitchp'
> arch/ppc/kernel/kernel.o(.text.init+0xbfa): undefined reference to
> `conswitchp'
> drivers/char/char.o: In function `chr_dev_init':
> drivers/char/char.o(.text.init+0x248): undefined reference to `fbmem_init'
> drivers/char/char.o(.text.init+0x248): relocation truncated to fit:
> R_PPC_REL24 fbmem_init
> make: *** [vmlinux] Error 1

Try activate the "Virtual terminal" and "Support for console on virtual
terminal".

JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
