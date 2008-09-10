Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2A83DE027
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:37:56 +1000 (EST)
Message-ID: <48C83E29.4070508@oracle.com>
Date: Wed, 10 Sep 2008 14:37:45 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: arch/powerpc/boot/.gitignore questions
References: <48C81ED5.1030701@oracle.com>
	<20080910164046.4813753b@wally.pikatech.com>
In-Reply-To: <20080910164046.4813753b@wally.pikatech.com>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> On Wed, 10 Sep 2008 12:24:05 -0700
> "Randy Dunlap" <randy.dunlap@oracle.com> wrote:
> 
>> Hi,
>>
>> I was looking at the arch/powerpc/boot/.gitignore file.
>> Why are all of those non-local-directory files listed there?
>> E.g., empty.c, inf*.c, inf*.h, zconf.h, zlib.h, zutil.h, etc.

Why would these files be listed in arch/powerpc/boot/.gitignore ??


>> And what is "dtc"?  I see a dtc-src directory, but "dtc" is MIA.
> 
> ./arch/powerpc/boot/dtc

Where do you see that?  That's not in 2.6.27-rc6 nor in the current
powerpc.git tree.  They both have:

> pwd
/var/linsrc/lin2627-rc6/arch/powerpc/boot
> ls -ld dt*
drwxr-xr-x 2 rdunlap users 4096 Jul 13 14:51 dtc-src/
drwxr-xr-x 2 rdunlap users 4096 Sep  9 19:33 dts/


which leads me to believe that the .gitignore entry should be either
dts or dtc-src or both, but not "dtc".


> I believe if the dts is built into u-boot, the dtc is not built.
> 
>> Same for kernel-vmlinux.strip.*
> 
> I don't see a vmlinux.strip.* rule. I ignore vmlinux.strip.

again, where are you looking?
This is in the current arch/powerpc/boot/.gitignore file.

~Randy
