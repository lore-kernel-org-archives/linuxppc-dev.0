Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0F6067A39
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 11:09:10 +1100 (EST)
In-Reply-To: <20060303232334.GA9577@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
	<3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
	<20060303232334.GA9577@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <68860BF1-B57E-481E-B51F-DA6F2A75EC3E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
Date: Sat, 4 Mar 2006 01:09:13 +0100
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The stack pointer is required to be 16-byte aligned when the
>> client program is started, on 32-bit as well.
>
> See http://ozlabs.org/pipermail/linuxppc-dev/2006-March/021342.html
>
> Either yaboot and/or zImage need to force a stack alignment, or we  
> apply
> the 2 liner.

Yaboot should do it.  Of course, it won't hurt if the kernel will
do it itself, too...


Segher
