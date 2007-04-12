Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08F38DDF8F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 23:54:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CDsQKY009926
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 09:54:26 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CDsPYv175340
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 07:54:25 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CDsPBC011676
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 07:54:25 -0600
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <89c4d64a1c2e654c8f339f008bbeddeb@bga.com>
References: <89c4d64a1c2e654c8f339f008bbeddeb@bga.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 08:53:22 -0500
Message-Id: <1176386002.6379.31.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 08:49 -0500, Milton Miller wrote:
> On Thu Apr 12 22:49:06 EST 2007, Josh Boyer wrote:
> > PowerPC 750CL has high BATs.  The patch below sets cpu_features to 
> > match that.
> > Without it, the original firmware mappings in the high BATs aren't 
> > cleared
> > which can cause "odd" address translations to occur.
> 
> Lets say what it does:  which continue to override the linux 
> translations.

Sure, that's exactly what it does since without the HIGH_BATS feature
Linux doesn't know about them and therefore can't clear them.

josh
