Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG68l55xgzDr1M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 20:21:43 +1100 (AEDT)
Date: Tue, 9 Jan 2018 20:18:55 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
Message-ID: <20180109091855.GB19326@fergus.ozlabs.ibm.com>
References: <20180109044815.GA19326@fergus.ozlabs.ibm.com>
 <1515486515.1993.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515486515.1993.2.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2018 at 07:28:35PM +1100, Suraj Jitindar Singh wrote:
[snip]
> > +	rc = plpar_get_cpu_characteristics(&c);
> > +	if (rc == H_SUCCESS) {
> > +		if (!(c.behavior &
> > H_GET_CPU_CHAR_BEHAV_L1_FLUSH_LOW_PRIV))
> 
> s/H_GET_CPU_CHAR_BEHAV_L1_FLUSH_LOW_PRIV/H_CPU_BEHAV_L1D_FLUSH_PR

Yes, somehow I managed to post an old version of the patch.  New
version coming.

Paul.
