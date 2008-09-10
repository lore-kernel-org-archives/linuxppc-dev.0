Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet02.oracle.com (rgminet02.oracle.com [148.87.113.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E275EDDF37
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 08:43:25 +1000 (EST)
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	by rgminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	m8ALnOs9016976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 15:49:24 -0600
Message-ID: <48C840CB.6050007@oracle.com>
Date: Wed, 10 Sep 2008 14:48:59 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: arch/powerpc/boot/.gitignore questions
References: <48C81ED5.1030701@oracle.com>	<20080910164046.4813753b@wally.pikatech.com>
	<48C83E29.4070508@oracle.com> <48C83FA7.70501@freescale.com>
In-Reply-To: <48C83FA7.70501@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Randy Dunlap wrote:
>>>> I was looking at the arch/powerpc/boot/.gitignore file.
>>>> Why are all of those non-local-directory files listed there?
>>>> E.g., empty.c, inf*.c, inf*.h, zconf.h, zlib.h, zutil.h, etc.
>>
>> Why would these files be listed in arch/powerpc/boot/.gitignore ??
> 
> Because they're created when building a bootwrapper?
> 
>>>> And what is "dtc"?  I see a dtc-src directory, but "dtc" is MIA.
>>> ./arch/powerpc/boot/dtc
>>
>> Where do you see that?  That's not in 2.6.27-rc6 nor in the current
>> powerpc.git tree.  They both have:
> 
> Of course not -- it wouldn't be in gitignore if it weren't a generated
> file.
> 
>>> pwd
>> /var/linsrc/lin2627-rc6/arch/powerpc/boot
>>> ls -ld dt*
>> drwxr-xr-x 2 rdunlap users 4096 Jul 13 14:51 dtc-src/
>> drwxr-xr-x 2 rdunlap users 4096 Sep  9 19:33 dts/
>>
>>
>> which leads me to believe that the .gitignore entry should be either
>> dts or dtc-src or both, but not "dtc".
> 
> Why would we want to ignore source directories?  dtc is the binary that
> is built from dtc-src.

Thanks.  Got it.

~Randy
