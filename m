Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2151B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 00:20:00 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p12D5Jod005335
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 06:05:19 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p12DJoou118332
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 06:19:50 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p12DJokl001789
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 06:19:50 -0700
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <85A99D1E-9B32-4816-91FD-355B325D3F8F@kernel.crashing.org>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
	<85A99D1E-9B32-4816-91FD-355B325D3F8F@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 02 Feb 2011 07:19:48 -0600
Message-ID: <1296652788.12290.5.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 01:48 -0600, Kumar Gala wrote:
> On Feb 1, 2011, at 12:48 PM, Dave Kleikamp wrote:
> 
> > Since other OS's may be running on the other cores don't use tlbivax
> 
> Are you guys building SMP kernel for use with AMP?  Just wondering why you'd be using tlbivax at all.

Yes, for instance, a 4-core chip could run two 2-way instances.

Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
