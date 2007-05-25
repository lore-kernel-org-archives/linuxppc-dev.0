Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C1934DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 01:01:06 +1000 (EST)
Message-ID: <4656FA60.7080600@mvista.com>
Date: Fri, 25 May 2007 08:01:52 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Fix compiler/assembler flags for Ebony platform boot files
References: <20070525031917.GC13575@localhost.localdomain>
	<1180101877.3360.39.camel@zod.rchland.ibm.com>
In-Reply-To: <1180101877.3360.39.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 2007-05-25 at 13:19 +1000, David Gibson wrote:
>> The recent addition of assembler flags for 44x.c and ebony.c in the
>> bootwrapper to make them compile on certain toolchains was not correct
>> and could break other platforms.  This patch switches to using a
>> compiler flag instead, which implies the appropriate assembler flag,
>> and also stops the compiler itself generating instructions which are
>> invalid for the platform in question.
> 
> This looks good to me, but I don't have one of the failing toolchains.
> Dave, can you test this patch out?
> 
> josh
> 

Built ok for me after the patch.
