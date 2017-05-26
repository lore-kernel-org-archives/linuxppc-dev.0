Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYw082sdHzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 15:38:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bharata B Rao <bharata@linux.vnet.ib>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <9b006866-5a8e-dc05-d603-bfe8eb02eef2@linux.vnet.ibm.com>
References: <9b006866-5a8e-dc05-d603-bfe8eb02eef2@linux.vnet.ibm.com>
Date: Fri, 26 May 2017 15:38:15 +1000
Message-ID: <87tw4889fc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> Removing or adding memory via the PowerPC hotplug interface shows
> anomalies in the association between memory and nodes.

What anomalies? Please describe the actual problem you're seeing, with
details, and why you think this is the correct fix.

This is a revert of 3af229f2071f ("powerpc/numa: Reset node_possible_map
to only node_online_map"), so please explain why all the things
mentioned in the change log for that commit are either wrong or no
longer true.

cheers
