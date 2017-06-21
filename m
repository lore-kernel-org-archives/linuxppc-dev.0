Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt0PS3J8HzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 19:52:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH V6 1/2] powerpc/hotplug: Ensure enough nodes avail for
 operations
In-Reply-To: <b506c509-45c3-fc17-9b83-24b30110748b@linux.vnet.ibm.com>
References: <b506c509-45c3-fc17-9b83-24b30110748b@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 19:52:27 +1000
Message-ID: <878tklu0pw.fsf@concordia.ellerman.id.au>
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

> powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU
> or memory resources, it may occur that the new resources are to be
> inserted into nodes that were not used for these resources at bootup.
> In the kernel, any node that is used must be defined and initialized
> at boot.  In order to meet both needs, this patch adds a new kernel
> command line option (numnodes=<int>) for use by the PowerPC architecture-

Sorry, that's a hack.

I thought you were going to use firmware properties to find the set of
possible nodes. Did that not work?

cheers
