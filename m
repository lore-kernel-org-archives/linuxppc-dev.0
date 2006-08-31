Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99D8967B5C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 17:47:44 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
Date: Thu, 31 Aug 2006 09:47:30 +0200
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608301401290.4217@schroedinger.engr.sgi.com>
	<20060831060036.GA18661@us.ibm.com>
In-Reply-To: <20060831060036.GA18661@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608310947.30542.ak@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, lnxninja@us.ibm.com,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 31 August 2006 08:00, Nishanth Aravamudan wrote:
> On 30.08.2006 [14:04:40 -0700], Christoph Lameter wrote:
> > > I took out the mlock() call, and I get the same results, FWIW.
> > 
> > What zones are available on your box? Any with HIGHMEM?
> 
> How do I tell the available zones from userspace? This is ppc64 with
> about 64GB of memory total, it looks like. So, none of the nodes
> (according to /sys/devices/system/node/*/meminfo) have highmem.

The zones are listed at the beginning of dmesg

"On node X total pages ...
      DMA zone ...
      ..." 

-Andi
