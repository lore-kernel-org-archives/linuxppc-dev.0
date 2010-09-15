Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E26F6B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:25:54 +1000 (EST)
Message-ID: <4C90835E.4050803@windriver.com>
Date: Wed, 15 Sep 2010 16:27:10 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201009151007.50706.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud wrote:
>>> How do I generate an elf file ?
>> vmlinux?
> 
> Thanks.
> 
> The entry point address has change and I can't upload it:
> New (bad) one:
> $ readelf -h vmlinux
> ...
>   Entry point address:               0xc0000000
> 
> Old (good) one:
> $ readelf -h zImage.elf 
> ...
>   Entry point address:               0x400000
> 
> How can I change the entry point address ?

It's impossible to boot PPC vmlinux format directly if you only change the
original entry point address, 0xc0000000.

For kernel the following is as default:
v:0xc0000000 --> p:0x0

Please use simpleImage.<your target dts name>.elf.

Cheers
Tiejun
