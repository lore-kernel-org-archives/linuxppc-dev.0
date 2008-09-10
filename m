Return-Path: <sean.maclennan@pikatech.com>
Received: from mail.pikatech.com (mail.pikatech.com [207.107.229.10])
	by ozlabs.org (Postfix) with ESMTP id F10F0DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 06:41:25 +1000 (EST)
Date: Wed, 10 Sep 2008 16:40:46 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: arch/powerpc/boot/.gitignore questions
Message-ID: <20080910164046.4813753b@wally.pikatech.com>
In-Reply-To: <48C81ED5.1030701@oracle.com>
References: <48C81ED5.1030701@oracle.com>
Mime-Version: 1.0
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

On Wed, 10 Sep 2008 12:24:05 -0700
"Randy Dunlap" <randy.dunlap@oracle.com> wrote:

> Hi,
> 
> I was looking at the arch/powerpc/boot/.gitignore file.
> Why are all of those non-local-directory files listed there?
> E.g., empty.c, inf*.c, inf*.h, zconf.h, zlib.h, zutil.h, etc.
> 
> And what is "dtc"?  I see a dtc-src directory, but "dtc" is MIA.

./arch/powerpc/boot/dtc

I believe if the dts is built into u-boot, the dtc is not built.

> Same for kernel-vmlinux.strip.*

I don't see a vmlinux.strip.* rule. I ignore vmlinux.strip.

Cheers,
   Sean
