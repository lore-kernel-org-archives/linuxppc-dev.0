Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id EF11267B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 07:04:44 +1000 (EST)
Date: Wed, 30 Aug 2006 14:04:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
In-Reply-To: <20060830072948.GE5195@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0608301401290.4217@schroedinger.engr.sgi.com>
References: <20060829231545.GY5195@us.ibm.com>
	<Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
	<20060830002110.GZ5195@us.ibm.com> <200608300919.13125.ak@suse.de>
	<20060830072948.GE5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, lnxninja@us.ibm.com, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I took out the mlock() call, and I get the same results, FWIW.

What zones are available on your box? Any with HIGHMEM?

Also what kernel version are we talking about? Before 2.6.18?
