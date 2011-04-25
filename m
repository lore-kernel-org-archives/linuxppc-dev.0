Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4886BB6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Apr 2011 00:05:18 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3PDxTOQ032154
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2011 07:59:29 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3PE51ts145610
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2011 08:05:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3PE3ZNK014785
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2011 08:03:36 -0600
Message-ID: <4DB57F39.7020003@linux.vnet.ibm.com>
Date: Mon, 25 Apr 2011 09:03:37 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: Add page coalescing support
References: <201104222108.p3ML8WQt002094@d03av05.boulder.ibm.com>
	<1303513178.2513.92.camel@pasglop>
In-Reply-To: <1303513178.2513.92.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2011 05:59 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-04-22 at 16:08 -0500, Brian King wrote:
>> Adds support for page coalescing, which is a feature on IBM Power servers
>> which allows for coalescing identical pages between logical partitions.
>> Hint text pages as coalesce candidates, since they are the most likely
>> pages to be able to be coalesced between partitions. This patch also
>> exports some page coalescing statistics available from firmware via
>> lparcfg.
> 
> Hi Brian !
> 
> Is this patch different from the version you posted previously which is
> already on Patchwork ? I'm in the process of putting together
> powerpc-next and your previous variant is in my queue.

Its the same, just a repost.

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
