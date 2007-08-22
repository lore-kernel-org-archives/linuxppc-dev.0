Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2002DDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 23:28:58 +1000 (EST)
In-Reply-To: <12268833.post@talk.nabble.com>
References: <12268833.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BEAC6061-FBAC-45EE-9D2A-C0904DDFECAD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.23-rc3 is not booting
Date: Wed, 22 Aug 2007 08:30:58 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 1:32 AM, sivaji wrote:

>
> Hai,
>          I am using the kernel 2.6.23-rc3. i am trying to boot this  
> kernel
> to my 8641D board. It was not booting.
> I go the following message
>
> Bytes transferred = 1505 (5e1 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.23-rc3
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1801717 Bytes =  1.7 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x800000
>
> Whether the problem belongs to device tree? I am using the  
> mpc8641_hpcn.dts
> file
>
> Pls Advice me.

What rev board/silicon do you have?  I'd suggest building the kernel  
w/o PCI support and see what happens.  Make sure you've got the  
latest dts from the kernel tree.

- k
