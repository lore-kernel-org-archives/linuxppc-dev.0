Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28CF7DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:27:03 +1000 (EST)
In-Reply-To: <20070529053445.GD30266@localhost.localdomain>
References: <20070529032924.GA30266@localhost.localdomain>
	<d35e07648ef5813bd9e3572eec36bfb3@kernel.crashing.org>
	<20070529053445.GD30266@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5dbbc18a80b465a00d6bbb764c06af86@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Don't use HOSTCFLAGS in BOOTCFLAGS
Date: Tue, 29 May 2007 08:26:49 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Also, is there any reason why you can't simply use $(CC) -m32 with
>> the kernel $(CFLAGS) ?
>
> I did think about that.  But the kernel CFLAGS does includes
> -ffixed-r2 and -Iarch/powerpc which I don't think we want here.

Both of these should be fairly harmless.  But sure, it
is cleaner to have separate flags -- the booter and the
kernel run in different environments, after all.


Segher
