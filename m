Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E7C5B70D0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 23:57:25 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o79DmWOM016841
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:48:32 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o79DuvSr071040
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:56:59 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o79DurmP030687
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 07:56:53 -0600
Message-ID: <4C600923.3030401@austin.ibm.com>
Date: Mon, 09 Aug 2010 08:56:51 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 6/9] v4 Update the find_memory_block declaration
References: <4C581A6D.9030908@austin.ibm.com>	<4C581C99.8090201@austin.ibm.com>
	<20100805135944.97ecbaa4.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100805135944.97ecbaa4.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2010 11:59 PM, KAMEZAWA Hiroyuki wrote:
> On Tue, 03 Aug 2010 08:41:45 -0500
> Nathan Fontenot <nfont@austin.ibm.com> wrote:
> 
>> Update the find_memory_block declaration to to take a struct mem_section *
>> so that it matches the definition.
>>
>> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
> Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Hmm...my mmotm-0727 has this definition in memory.h...
> 
> extern struct memory_block *find_memory_block(struct mem_section *);
> 
> What patch makes it unsigned long ?
> 

I was basing the patches on the latest mainline tree.  Looks like  can drop
this patch in the next version of the patchset.

-Nathan
