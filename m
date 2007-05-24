Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 893B5DDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 23:40:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4ODenk5029276
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:40:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4ODemv1216266
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:40:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4ODemBr020264
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 07:40:48 -0600
Subject: Re: Don't store a command line in the Holly device tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070524040210.GC20078@localhost.localdomain>
References: <20070524040210.GC20078@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 May 2007 08:39:54 -0500
Message-Id: <1180013994.3360.11.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: Hugh Blemings <hab@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-24 at 14:02 +1000, David Gibson wrote:
> Currently, the Holly device tree includes a bootargs property in
> /chosen, which gives a commandline.  This is somewhat inconvenient,
> because it means an alternative default command line can't be given in
> the kernel config - the value obtained from the dts via the
> bootwrapper will always override CONFIG_CMDLINE.
> 
> This patch removes the command line from the dts, and instead puts the
> same command line as a default in holly_defconfig.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
