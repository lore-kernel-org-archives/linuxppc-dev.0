Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D185F1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 14:34:31 +1100 (AEDT)
Message-ID: <1414380870.24967.0.camel@concordia>
Subject: Re: [PATCH] cpuidle/powernv: Populate cpuidle state details by
 querying the device-tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Mon, 27 Oct 2014 14:34:30 +1100
In-Reply-To: <20141024143030.GA25966@red-moon>
References: <20141014075259.11810.50996.stgit@preeti.in.ibm.com>
 <20141024143030.GA25966@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "shreyas@linux.vnet.ibm.com" <shreyas@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-24 at 15:30 +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 14, 2014 at 08:53:00AM +0100, Preeti U Murthy wrote:
> > We hard code the metrics relevant for cpuidle states in the kernel today.
> > Instead pick them up from the device tree so that they remain relevant
> > and updated for the system that the kernel is running on.
> 
> Device tree properties should be documented, and these bindings are
> getting very similar to the ones I have just completed for ARM,
> I wonder whether we should take the generic bits out of ARM bindings (ie
> exit_latency) and make those available to other architectures.

The firmware that emits those properties is already in the field, so it would
have been nice to use a generic binding but it's too late now.

cheers
