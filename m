Message-ID: <000901c0d8fe$78abed40$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Dan Malek" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c0d5c8$27ae8c60$8021690a@huawei.com> <3AF6F323.7944F695@mvista.com>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Date: Thu, 10 May 2001 11:08:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> machael thailer wrote:
> > ..... But I met
> > some urgent problems ...
> >     I modified the bootloader codes according to arch/ppc/mbxboot/head.S
>
> For starters, you shouldn't be using this "boot loader" for a 750.....
> How did you configure a kernel to get there in the first place?
> A 750 should be a CHRP (or PReP, if you have to.....), which will
> direct you to a working "chrpboot" boot loader.

If I use  "chrpboot " bootloader, I have to provide many functions in my
boot codes according to CHRP specifications:

1  "prom"(promptr) functions which can provide with "/chosen" ,"claim" and
"getprop" services etc in arch/ppc/chrpboot/start.c and in
arch/ppc/kernel/prom.c .
2  device-trees for my custom board.

Are these functions all necessary for booting the linux kernel?


And do I have to  modify arch/ppc/mm/init.c=>MMU_init() and
arch/ppc/kernel/setup.c=>identify_machines() to suit my cases?
I notice that in identify_machines(), there are many types initializations
functions such as pmac_init(),prep_init(),chrp_init(),apus_init(),
oak_init(),m8xx_init(),m8260_init(). Do I have to provide my own ***_init()
functions?


Thank you  very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
