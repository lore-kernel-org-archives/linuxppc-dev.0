Message-ID: <3E7A431D.7090102@elitedvb.net>
Date: Thu, 20 Mar 2003 23:39:25 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: Pascal <pascal@ece.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot
References: <000d01c2eeaf$83a4fa70$2dbe3e3e@cmh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pascal wrote:
> I'm working on a motorola MPc8xx. i would like to know if it's possible
>  to run ppcboot trough an another ppcboot
on dbox2, we boot the ppcboot-elf from another firststage bootloader. works.


on another system (dreambox), i boot u-boot from another firststate
bootloader (IBM's openbios.). works.


just take out all sdram init stuff et al and produce a file loadble from
  your bootloader.


felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
