Return-Path: <jdi@l4x.org>
Received: from mail.trixing.net (mail.trixing.net [87.230.125.58])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 428FCDE152
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 07:13:34 +1100 (EST)
Message-ID: <47263830.2010009@l4x.org>
Date: Mon, 29 Oct 2007 20:44:48 +0100
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten>
	<jesl3udm0e.fsf@sykes.suse.de>	<4725F34C.6090904@ppp0.net>
	<jelk9mdj6e.fsf@sykes.suse.de>
In-Reply-To: <jelk9mdj6e.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jan Dittmer <jdittmer@ppp0.net>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Jan Dittmer <jdittmer@ppp0.net> writes:
> 
>> $ powerpc64-linux-gcc-4.0.4 -v
>> Using built-in specs.
>> Target: powerpc64-linux
>> Configured with: ../configure --prefix=/usr/cc217
>> --exec-prefix=/usr/cc217/powerpc64 --target=powerpc64-linux
>> --disable-shared --disable-werror --disable-nls --disable-threads
>> --disable-werror --disable-libmudflap --with-newlib --with-gnu-as
>> --with-gnu-ld --enable-languages=c
>> Thread model: single
>> gcc version 4.0.4
>>
>> g5_defconfig:
>>
>> $ make ARCH=powerpc HOSTCC=gcc-4.0 CROSS_COMPILE=powerpc64-linux- 
>> CROSS32_COMPILE=powerpc64-linux-
> 
> Your compiler still needs -m32 to generate 32-bit code (or use
> --with-cpu=default32 to make that the default).

4.1.2 exhibits the same behavior. When did it start to work without
additional options? 4.2?

Jan
