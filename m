Message-ID: <39C820B5.D34ADBE1@serialsystem.com.sg>
Date: Wed, 20 Sep 2000 09:28:05 +0700
From: Jari <jari.nguyen@serialsystem.com.sg>
Reply-To: jari.nguyen@serialsystem.com.sg
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Prashant Patel <pmpatel@trinetcommunication.com>,
        linuxppc-embedded@lists.linuxppc.org, thanh_nguyen@smartstors.com
Subject: Re: 4MB DRAM is enough for linux kernel 2.2.13
References: <002101c0225b$976c4f40$4d1f76d8@kennedy> <39C7A03A.93075582@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I'm a newbie. Help me!!!!!
Can anybody tell me the minimum size of the linux kernel 2.2.13  that we can
reduce?
(this kernel doesn't need console, anything else ... just boot and run my own
program)
If I want to support only ftp, what is the minimum size of ramdisk ?
I think if I reduce the code of the kernel and the library libc6, 4MB is OK.
Is that right?
best regards,
Jari

ps: Hi Dan "grandfather of all of these", you wrote:

>         I like MMUs because I don't have a real life.

How old are you in this life?
I've just had my full-month celebration.  ;-))) just relax....





Dan Malek wrote:

> Prashant Patel wrote:
> >
> > Hello Everybody
> >         Can someone tell me if 4MB DRAM is enough to boot linux kernel
> > 2.2.13. Note that the 8xx rom boot loader occupies around 500k.
>
> Yes, I can say it will not work.
>
> The code in the arch/ppc/mbxboot directory, which is used for
> all 8xx and 8260 processors, assumes there is memory above 4 MB
> it can use for buffer space while decompressing the kernel.  You
> can play around with adjusting these addresses and sizes, and get
> a kernel to boot.  You will get a shell prompt, and that is about
> all.  You won't be able to use a ramdisk, you probably won't be
> able to execute any useful programs.
>
>         -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
