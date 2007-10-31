Return-Path: <haveblue@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CE02DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 08:55:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VLtCWh011083
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 17:55:12 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VLtBiA090832
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 15:55:11 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VLtAee013281
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 15:55:11 -0600
Subject: Re: [PATCH 1/3] Add remove_memory() for ppc64
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1193868715.17412.55.camel@dyn9047017100.beaverton.ibm.com>
References: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
	<1193863502.6271.38.camel@localhost>
	<1193868715.17412.55.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 14:55:03 -0700
Message-Id: <1193867703.6271.42.camel@localhost>
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

On Wed, 2007-10-31 at 14:11 -0800, Badari Pulavarty wrote:
> 
> Well, We don't need arch-specific remove_memory() for ia64 and ppc64.
> x86_64, I don't know. We will know, only when some one does the
> verification. I don't need arch_remove_memory() hook also at this
> time.

I wasn't being very clear.  I say, add the arch hook only if you need
it.  But, for now, just take the ia64 code and make it generic.  

-- Dave
