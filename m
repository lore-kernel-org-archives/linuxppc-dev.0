Return-Path: <dank@kegel.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id C189A67A64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 00:10:29 +1000 (EST)
Message-ID: <42514AC4.8030602@kegel.com>
Date: Mon, 04 Apr 2005 07:10:12 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Christian <evilninja@gmx.net>
References: <423B788F.7040705@kegel.com> <42509DB9.4090609@gmx.net>
	<425147C4.10906@gmx.net>
In-Reply-To: <425147C4.10906@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: gcc4 compile fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> replying to myself:
> 
> Christian wrote:
> 
>>now it [1] fails with:
>>
>>In file included from arch/ppc/kernel/time.c:68:
>>include/asm/time.h:61: warning: type qualifiers ignored on function return
>>type
> 
> [...]
> 
> ..and there were other error messages too. not knowing a *bit* of C, i was
> able to do minor alterations which i deduced from gcc's error messages.
> now compiling for ppc604 (PReP) with gcc4 succeeds.

Thanks for the report and the patch.
Parts of that patch look like ones I've already collected at:
http://www.kegel.com/crosstool/crosstool-0.30/patches/linux-2.6.11.3/
Here are the patches I have so far:
kaz-types.patch
linux-2.6.11-allow-gcc-4.0-asm-i386.patch
linux-2.6.11-allow-gcc-4.0-asm-m68k.patch
linux-2.6.11-allow-gcc-4.0-asm-ppc64.patch
linux-2.6.11-allow-gcc-4.0-asm-x86_64.patch
linux-2.6.11-allow-gcc-4.0-i2c.patch
linux-2.6.11-allow-gcc-4.0-ppc-mikpe.patch

In particular,
http://www.kegel.com/crosstool/crosstool-0.30/patches/linux-2.6.11.3/linux-2.6.11-allow-gcc-4.0-ppc-mikpe.patch
covers some of what you found.

Maybe if I apply your first patch, I'll make it all the way through.

Thanks,
Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
