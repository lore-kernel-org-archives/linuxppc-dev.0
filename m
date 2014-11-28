Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BC441A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 03:00:24 +1100 (AEDT)
Date: Fri, 28 Nov 2014 10:00:11 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Message-ID: <20141128160011.GB28943@gate.crashing.org>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20141127165650.GA28278@gate.crashing.org>
 <5477E492.4000009@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5477E492.4000009@linux.vnet.ibm.com>
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 28, 2014 at 08:27:22AM +0530, Madhavan Srinivasan wrote:
> > Have you tested this with (upcoming) GCC 5.0?  GCC now uses CR5,
> > and it likes to use it very much, it might be more convenient to
> > use e.g. CR1 (which is allocated almost last, only before CR0).
> > 
> No. I did not try it with GCC5.0 But I did force kernel compilation with
> fixed-cr5 which should make GCC avoid using CR5. But i will try that today.

It should work just fine, but testing is always useful, because, you know,
"should".  Thanks.


Segher
