Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA43267CAF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 02:06:15 +1100 (EST)
In-Reply-To: <22A704B880BBD94A9E52BD6FA90C63D787241F@BUDMLVEM08.e2k.ad.ge.com>
References: <22A704B880BBD94A9E52BD6FA90C63D787241F@BUDMLVEM08.e2k.ad.ge.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <47F903F7-9371-4FA7-96CF-DB13AFF07827@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linux on PowerQUICC 8349E
Date: Thu, 14 Dec 2006 09:06:11 -0600
To: "Awad, Sinan ((GE Healthcare))" <sinan.awad@med.ge.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 14, 2006, at 5:50 AM, Awad, Sinan ((GE Healthcare)) wrote:

> Hello all
>
> I'm new to this list, so please be gentle ;)
> I've been working on vxWorks (5-6) for a few years on powerquicc CPUs.
>
> I wanted to check the option of moving to linux, I have a windriver  
> sbc8349 evb, which I would like to boot linux on.
> - I downloaded crosstool, and am building the ppc603 toolchain (is  
> that OK ? or is there some better toolchain ?)
> - Where do I go now ? I downloaded the latest kernel from  
> kernel.orgmn and...

That's the right crosstool target.

> I am quite ok on linux, yet never cross-compiled or brought-up a  
> board based on some flavor of linux..
>
> I have searched the web for information, but the sources of  
> knowledge are quite sparse and not helpfull..

I'd suggest taking a look at a book like 'Building Embedded Linux  
Systems' for general information about building the kernel and so forth.

For the MPC8349 the latest kernel supports the Freescale reference  
boards and its my understanding that the windriver sbc8349 is pretty  
close to the Freescale MPC8349E MDS board.

I would think if you contacted WindRiver that'd provide some help in  
getting linux running on their board.

> Can someone please point me to a starting point, so that I can at  
> least flash a bootloader to the board, with some sort of BSP, so  
> that I can see at least some linux prompt on the serial port ? ;)

I'd take a look at the 'ltib' project from Freescale.  Its how they  
are doing BSPs for their boards.  Its an open source project and the  
guys working on it are pretty helpful.  It will get you an  
environment setup that you can use to do development (cross compiler,  
kernel, u-boot, rootfs packages, etc.).

- kumar

>
> Thanks in advance.
> Sinan..
>
>
>
>
> Notice: This e-mail and accompanying files contain confidential  
> information, belonging to the sender that is legally privileged.  
> This information is intended only for use by the individual or  
> entity designated. The authorized recipient of this information is  
> prohibited from disclosing the information to any other party and  
> is required to destroy the information after its stated need has  
> been fulfilled. If you are not the intended recipient, you are  
> hereby notified that any disclosure, copying, distribution, or  
> action taken in reliance on the contents of these documents is  
> strictly prohibited. If you have received this copy in error,  
> please notify the sender immediately and destroy all copies of this  
> information, including any attachments, without reading or  
> disclosing them. Thank You
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
