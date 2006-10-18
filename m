Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 4CE25679E1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 02:06:34 +1000 (EST)
Date: Wed, 18 Oct 2006 09:06:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610180858440.27799@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Oct 2006, Paul Mackerras wrote:

> Linus' tree is currently broken for us.  Any suggestions for how to
> fix it, since I am not very familiar with the NUMA code?

I am not very familiar with the powerpc code and what I got here is 
conjecture from various messages. It would help to get some clarification 
on what is going on with node 0 memory. Is there really no memory 
available from node 0 on bootup? Why is this? 

If this is the case then you already have had issues for long time with 
per node memory lists being contaminated on bootup.

Why would you attempt to boot linux on a memory node without 
memory?
