Return-Path: <mkravetz@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AE2867C04
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 08:00:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DM0ue1008143
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:00:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DM0uGn282358
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:00:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DM0uNg000915
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:00:56 -0400
Date: Fri, 13 Oct 2006 15:01:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061013220134.GB4974@monkey.ibm.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<20061013212202.GG28620@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061013212202.GG28620@localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 13, 2006 at 04:22:02PM -0500, Nathan Lynch wrote:
> Will Schmidt wrote:
> > NUMA associativity depth for CPU/Memory: 3
> > adding cpu 0 to node 0
> > node 0
> > NODE_DATA() = c000000015ffee80
> > start_paddr = 8000000
> > end_paddr = 16000000
> > bootmap_paddr = 15ffc000
> > reserve_bootmem ffc0000 40000
> > reserve_bootmem 15ffc000 2000
> > reserve_bootmem 15ffee80 1180
> > node 1
> > NODE_DATA() = c000000021ff7c80
> > start_paddr = 0
> > end_paddr = 22000000
> 
> Strange, node 0 appears to be in the middle of node 1.

IIRC, this is fairly common.  Or, it was on the system/LPAR I had access
to.  I'd check again, but I lost easy access to that system. :(

-- 
Mike
