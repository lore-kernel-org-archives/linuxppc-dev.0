Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D790B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 01:32:51 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p04EIgK2008084
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 07:18:42 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p04EWdxm099678
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 07:32:39 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p04EWd9K007548
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 07:32:39 -0700
Date: Tue, 4 Jan 2011 09:31:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/dts: fix syntax bugs in bluestone.dts
Message-ID: <20110104143132.GC2364@zod.rchland.ibm.com>
References: <20110103210715.10427.56175.stgit@localhost6.localdomain6>
	<20110104135930.GA2364@zod.rchland.ibm.com>
	<20110104143030.GA11738@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110104143030.GA11738@angua.secretlab.ca>
Cc: tmarri@apm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 04, 2011 at 07:30:30AM -0700, Grant Likely wrote:
>On Tue, Jan 04, 2011 at 08:59:31AM -0500, Josh Boyer wrote:
>> On Mon, Jan 03, 2011 at 02:07:40PM -0700, Grant Likely wrote:
>> >Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> >---
>> >
>> >I'm picking this one up immediately into my next-devicetree branch
>> 
>> Hm.  So these are of course correct, and with that:
>> 
>> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> 
>> but I do wonder how you noticed them?  DTC didn't throw an error when I
>> built this originally.  Either way, more diligence on my part would be
>> appropriate, but knowing how you came across these might teach me
>> something.
>
>I updated the copy of dtc in the kernel and rebuilt all the .dts files.

Are you going to push that DTC update into the kernel as well?

josh
