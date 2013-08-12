Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CA922C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 16:02:59 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 12 Aug 2013 07:02:55 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1304638C8027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 02:02:52 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7C62rml090846
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 02:02:53 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7C62r8R005775
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 02:02:53 -0400
Date: Sun, 11 Aug 2013 23:02:28 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Build errors on mainline kernel
Message-ID: <20130812060228.GA8608@us.ibm.com>
References: <20130809182446.GA26711@us.ibm.com>
 <1376286123.2066.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376286123.2066.7.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Fri, 2013-08-09 at 11:24 -0700, Sukadev Bhattiprolu wrote:
| > I am tryng to compile clean mainline kernel with a few different config files
| > and running into errors with some configs.
| > 
| > I am building on RHEL6.3 with following binaries:
| > 
| > 	gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4)
| > 	GNU ld version 2.20.51.0.2-5.34.el6 20100205
| > 	binutils-2.20.51.0.2-5.34.el6.ppc64
| > 	binutils-devel-2.20.51.0.2-5.34.el6.ppc64
| > 
| > I am getting the error with several files and configs, but other configs 
| > (eg: ppc64_defconfig, pmac32_defconfig) build fine.
| > 
| > For instance, with latest mainline kernel (commit 6c2580c) and ppc64_defconfig, I get:
| 
| Here you say ppc64_defconfig ..

That was a stupid typo. ppc64_defconfig works.

| 
| > 	make O=linux-obj mrproper
| > 	make O=linux-obj ppc64e_defconfig
| 
| But here you say ppc64e_defconfig ?

ppc64e_defconfig fails (checked again now).
