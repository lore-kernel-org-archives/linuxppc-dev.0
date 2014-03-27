Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7DD25140084
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 17:28:58 +1100 (EST)
Message-ID: <1395901724.5569.83.camel@pasglop>
Subject: Re: [PATCH v4] powernv: Dynamic Frequency Scaling Enablement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 27 Mar 2014 17:28:44 +1100
In-Reply-To: <CAKohpom-mnOXpOUChasOMVTrRGknvZNA_bOcq6ZfGTRmUM5W9A@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohpom-mnOXpOUChasOMVTrRGknvZNA_bOcq6ZfGTRmUM5W9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-27 at 11:08 +0530, Viresh Kumar wrote:
> On 26 March 2014 22:25, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
> > This is the v4 of the patchset to enable Dynamic Frequency Scaling
> > on IBM PowerNV Platforms. I have incorporated the review comments
> > from the previous version (can be found at [1]).
> 
> I wouldn't have added a cover-letter if I only have a single patch to
> send. Would have rather used the not-to-be-commited field of the
> patch instead.

Any other comment ? :-)

Because it depends on some other stuff in -next, I think it's best if
this gets merged via Rafael's tree, unless someone can point me at
the necessary pre-requisites in the form of a topic branch I can
pull in powerpc along with this.

Cheers,
Ben.
