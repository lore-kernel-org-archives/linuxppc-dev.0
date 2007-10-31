Return-Path: <pbadari@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12779DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 07:42:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VKg5Gi000857
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 16:42:05 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VKg5Oi124882
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 14:42:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VKg4Vs017151
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 14:42:05 -0600
Subject: Re: [PATCH 1/3] Add remove_memory() for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <46434BBD-7656-41B1-BED0-3A3E212032B5@kernel.crashing.org>
References: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
	<46434BBD-7656-41B1-BED0-3A3E212032B5@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 13:45:33 -0800
Message-Id: <1193867133.17412.49.camel@dyn9047017100.beaverton.ibm.com>
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

On Thu, 2007-11-01 at 01:26 -0500, Kumar Gala wrote:
> On Oct 31, 2007, at 11:49 AM, Badari Pulavarty wrote:
> 
> > Supply arch specific remove_memory() for PPC64. There is nothing
> > ppc specific code here and its exactly same as ia64 version.
> > For now, lets keep it arch specific - so each arch can add
> > its own special things if needed.
> >
> > Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> > ---
> 
> What's ppc64 specific about these patches?

Like I mentioned, nothing. When KAME did the hotplug memory
remove, he kept this remove_memory() arch-specific - so
each arch can provide its own, if it needs to something
special. So far, there is no need for arch-specific 
remove_memory(). If other archs (x86-64 and others)
agree we can merge this into arch neutral code.

I have to provide this for ppc64 to plug into general
frame work.

Thanks,
Badari
