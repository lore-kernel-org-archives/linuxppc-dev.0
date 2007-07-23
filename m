Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F0AADDE38
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 23:14:18 +1000 (EST)
Message-ID: <46A4A9DC.6010602@freescale.com>
Date: Mon, 23 Jul 2007 08:15:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Someone broke my allmodconfig build
References: <20070722001212.5007001d.sfr@canb.auug.org.au>	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
	<20070722115354.0c28d704.sfr@canb.auug.org.au>
In-Reply-To: <20070722115354.0c28d704.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:

>> Hmmm, we should be shipping .dtb files with the tree, so people don't
>> have to have dtc installed.
> 
> Unless, of course, we ship dtc ...

I like that idea.

I don't know much about the kernel build process, but is it normal to ship C files and have kbuild build them and then use the executables to build the rest of the kernel?
