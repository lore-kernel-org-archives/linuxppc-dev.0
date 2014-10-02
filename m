Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9A191A1A9B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 08:24:14 +1000 (EST)
Message-ID: <1412288639.28143.38.camel@pasglop>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 03 Oct 2014 08:23:59 +1000
In-Reply-To: <20141002215305.GA20262@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <20141002211305.GB12862@linux.vnet.ibm.com>
 <1412285299.28143.33.camel@pasglop>
 <20141002215305.GA20262@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 14:53 -0700, Nishanth Aravamudan wrote:
> On 03.10.2014 [07:28:19 +1000], Benjamin Herrenschmidt wrote:
> > On Thu, 2014-10-02 at 14:13 -0700, Nishanth Aravamudan wrote:
> > > Ben & Michael,
> > > 
> > > What's the status of these patches?
> > 
> > Waiting for somebody to review them ? :-)
> 
> Heh, I acked them about a month ago, I can give a stronger Reviewed-by,
> if you prefer?

Nah, nothing other than having me or mpe pick them up. I've been letting
Michael handle this merge window, so maybe he should take it :-)

Cheers,
Ben.
