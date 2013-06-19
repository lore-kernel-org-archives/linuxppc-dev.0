Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 26B672C02F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 20:20:45 +1000 (EST)
Message-ID: <1371637113.21896.274.camel@pasglop>
Subject: Re: [PATCH] powerpc/THP: Wait for all hash_page calls to finish
 before invalidating HPTE entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Wed, 19 Jun 2013 20:18:33 +1000
In-Reply-To: <9335.1371626096@ale.ozlabs.ibm.com>
References: <1371624294-19451-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <7312.1371624946@ale.ozlabs.ibm.com> <87ehbymvif.fsf@linux.vnet.ibm.com>
 <9335.1371626096@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-19 at 17:14 +1000, Michael Neuling wrote:

> > This is a bug fix. The details can be found at 
> 
> Can you make this more obvious in the changelog (as well as making it 80
> col).  I don't see 'bug' mentioned anywhere.  'Fix' is mentioned
> somewhere in the middle of the changelog.
> 
> > 
> > http://article.gmane.org/gmane.linux.ports.ppc.embedded/60266
> 
> OK, but V10 THP is not in yet, right?  So why not roll it into that
> series rather than pushing broken stuff and fixing it?

Right, this is expected. This fix is a result of me asking him to do it
that way on ST and should eventually be folded in the series (or
re-ordered to be in there before the patch that enables THP).

Cheers,
Ben.
