Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5D4E8DE2A1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 00:51:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Big include file move breaks user mode
Date: Wed, 6 Aug 2008 16:51:40 +0200
References: <20080805120916.2f39307c@lappy.seanm.ca>
In-Reply-To: <20080805120916.2f39307c@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808061651.40361.arnd@arndb.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 August 2008, Sean MacLennan wrote:
> Should include/asm be a link to arch/powerpc/include/asm?

The user space headers are provided by your distribution, not
by the kernel, so include/asm should be a directory, not a symlink.
If you are building your own distro, don't just copy the files
but rather use 'make headers_install' to get a sanitized version.

	Arnd <><
