Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D6D2FB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 23:46:38 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88F9DDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 23:46:38 +1000 (EST)
Message-ID: <4A841933.8090808@embedded-sol.com>
Date: Thu, 13 Aug 2009 16:46:27 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Scott Wood <scottwood@freescale.com>
Subject: Adding MTD concat support to FSL ELBC NAND driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'd like to be able to concatenate several NAND banks (each bank on 
separate chip select)
into a single MTD device, and define partition table on a concatenated 
device.

Currently concatenation support is implemented in physmap_of driver. The 
syntax used
to define a concatenation device involves multiple reg tuples, as 
described in
Documentation/powerpc/dts-bindings/mtd-physmap.txt. Will same syntax be 
acceptable
for NAND chips ?

Thanks.

Felix.
