Return-Path: <jdi@l4x.org>
Received: from rzcomm22.rz.tu-bs.de (rzcomm22.rz.tu-bs.de [134.169.9.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC8EADE007
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:15:51 +1100 (EST)
Message-ID: <472758AE.70207@l4x.org>
Date: Tue, 30 Oct 2007 17:15:42 +0100
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten>
	<jesl3udm0e.fsf@sykes.suse.de>	<4725F34C.6090904@ppp0.net>
	<jelk9mdj6e.fsf@sykes.suse.de>	<47263830.2010009@l4x.org>
	<jebqahei70.fsf@sykes.suse.de>	<47265586.1050701@l4x.org>
	<je640pebqn.fsf@sykes.suse.de>	<4726DD82.8050200@l4x.org>
	<jey7dlez74.fsf@sykes.suse.de>
In-Reply-To: <jey7dlez74.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Jan Dittmer <jdi@l4x.org> writes:
> 
>> Your mail from 2007-10-29 4:39 pm (CET)
>>
>>>> Your compiler still needs -m32 to generate 32-bit code (or use
>>>> --with-cpu=default32 to make that the default).
>> See the 'still' ?
> 
> How would the compiler know whether to generate 64bit or 32bit code??

Andreas, I think we both got a bit lost. Lets take a step back.

The original problem was that after 2.6.23 cross compiling
powerpc/g5_defconfig broke (Regression). Using gcc 4.0.4, powerpc64
target as cross compiler and powerpc target as 32-bit cross compiler.

Since 2.6.23-git1 it is now broken. Using gcc 4.1.2 didn't fix this. Neither
with "--with-cpu=default32" present nor without. So could you please
explain to me how I'm supposed to cross compile powerpc/g5_defconfig now?
Passing CFLAGS=-m32 didn't help too.

Or is it just a new bug in the kernel make system?

Just for reference up till 2.6.23 I used the following command:
make ARCH=powerpc HOSTCC=gcc-4.0 CROSS_COMPILE=powerpc64-linux-  \
	CROSS32_COMPILE=powerpc-linux-

Thanks,

Jan
