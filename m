Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EA2C2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 15:02:20 +1100 (EST)
Message-ID: <1393992008.11372.1.camel@pasglop>
Subject: Re: [PATCH] powerpc/powernv: Read OPAL error log and export it
 through sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 15:00:08 +1100
In-Reply-To: <53169971.8050607@linux.vnet.ibm.com>
References: <87k3cin5kd.fsf@river.au.ibm.com>
 <1393549112-6101-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C7B6.1030602@linux.vnet.ibm.com> <87vbvtjtmh.fsf@river.au.ibm.com>
 <53169971.8050607@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-05 at 08:56 +0530, Vasant Hegde wrote:
> On 03/05/2014 07:26 AM, Stewart Smith wrote:
> > Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> >>> +int64_t opal_send_ack_elog(uint64_t log_id);
> >>
> >> Stewart,
> >>
> >> Why are you creating 64bit log ID  when actual ID is 32bit ?
> >
> > IIRC it's what OPAL gives us, even though FSP MBOX spec says 32bit.
> >
> 
> Stewart,
> 
> Better ask OPAL folks to fix in firmware ?

Why bother ? That way if future versions of OPAL want to use 64-bit IDs,
they can.

Cheers,
Ben.
