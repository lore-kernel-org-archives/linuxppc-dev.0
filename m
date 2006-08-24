Return-Path: <jdub@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 227DB67C87
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 22:49:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7OCnVEH016532
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 08:49:31 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7OCnTeY258190
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 06:49:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7OCnTqp008136
	for <linuxppc-embedded@ozlabs.org>; Thu, 24 Aug 2006 06:49:29 -0600
Subject: Re: ARCH=ppc or ARCH=powerpc
From: Josh Boyer <jdub@us.ibm.com>
To: Parav Pandit <paravpandit@yahoo.com>
In-Reply-To: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 07:49:56 -0500
Message-Id: <1156423796.5640.23.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: BDE@teamlog.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 05:38 -0700, Parav Pandit wrote:
> ppc = 32bit.
> powerpc= 64bit.
> Correct me if I am wrong.

Yes, you're wrong.  Some 32 bit boards are also under arch/powerpc now.

>  
> I am not sure why community didn't adopt the name ppc and ppc64 just
> like ia-32 and ia64.

They did originally.

The new direction is to have everything under arch/powerpc, both 32 and
64 bit.  The reason arch/ppc still exists is because some 32 bit
platforms have not been fully migrated to the requirements to be merged
into arch/powerpc.  Namely, the code has to boot from an OpenFirmware
like flattened device tree.  The PPC 4xx family of processors, as an
example, does not do this yet though there is work going on to adapt it.

Eventually, arch/ppc will go away and all of PowerPC will be under
arch/powerpc.  That's the goal anyway.

josh
