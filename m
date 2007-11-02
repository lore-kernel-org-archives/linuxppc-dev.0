Return-Path: <pbadari@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 028F0DDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 02:31:07 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	lA2EUdMh005228
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 10:30:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA2FE78b047752
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 09:31:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA2Es5tW015565
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 08:54:05 -0600
Subject: Re: [PATCH 3/3] Add arch-specific walk_memory_remove() for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1193999530.25744.3.camel@johannes.berg>
References: <1193849335.17412.33.camel@dyn9047017100.beaverton.ibm.com>
	<1193999530.25744.3.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 02 Nov 2007 07:57:18 -0800
Message-Id: <1194019038.1547.0.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, anton@au1.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-11-02 at 10:32 +0000, Johannes Berg wrote:
> > This patch provides a way for an architecture to provide its
> > own walk_memory_resource()
> 
> It seems that the patch description "walk_memory_remove()" is wrong?
> 

Yep. Patch title is wrong.

Thanks,
Badari
