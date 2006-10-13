Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B2C567C64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:28:03 +1000 (EST)
In-Reply-To: <200610130653.k9D6r0Jq028482@bLinux.pontusys.com>
References: <200610130653.k9D6r0Jq028482@bLinux.pontusys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <19C2D57F-FDA8-4D5A-8997-F461B0275351@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: unresolved symbol on target ... while insmod
Date: Fri, 13 Oct 2006 10:28:12 -0500
To: kwkang <kwkang@pontusys.com>
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


On Oct 13, 2006, at 1:49 AM, kwkang wrote:

> Hi Srideep,
>
>
>
> Can anyone show me how I can overcome below problem?
>
> I have searched mailing list but I can not find any answer for that  
> problem.
>
>
>
> [test ~]#insmod linux-kernel-bde.o
>
> Using linux-kernel-bde.o
>
> Using linux-kernel-bde.o
>
> insmod: Warning: kernel-module version mismatch
>
>         linux-kernel-bde.o was compiled for kernel version 2.4.20_dev
>
>         while this kernel is version 2.4.21-pre5
>
> insmod: unresolved symbol devfs_register
>
> insmod: unresolved symbol devfs_unregister

This most likely means you dont have devfs built into your kernel or  
the module for devfs isn't loaded.

- k
