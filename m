Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 977322C00AD
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 07:58:54 +1100 (EST)
Message-ID: <1383512261.4776.21.camel@pasglop>
Subject: Re: perf events ring buffer memory barrier on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Mon, 04 Nov 2013 07:57:41 +1100
In-Reply-To: <OF57D6EF77.CD2E45CE-ON42257C16.005AA6D8-42257C16.005AB961@il.ibm.com>
References: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <OFDF23985D.1D949148-ON42257C15.002DEB25-42257C15.0036DF93@il.ibm.com>
 <20131031152543.GC4067@linux.vnet.ibm.com>
 <OF3CB471BA.BACC7843-ON42257C16.0055EF23-42257C16.0058875B@il.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B73D4@saturn3.aculab.com>
 <OF57D6EF77.CD2E45CE-ON42257C16.005AA6D8-42257C16.005AB961@il.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 David Laight <David.Laight@aculab.com>, Anton Blanchard <anton@samba.org>,
 paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-01 at 18:30 +0200, Victor Kaplansky wrote:
> "David Laight" <David.Laight@aculab.com> wrote on 11/01/2013 06:25:29 PM:
> > gcc will do unexpected memory accesses for bit fields that are
> > adjacent to volatile data.
> > In particular it may generate 64bit sized (and aligned) RMW cycles
> > when accessing bit fields.
> > And yes, this has caused real problems.
> 
> Thanks, I am aware about this bug/feature in gcc.

AFAIK, this has been fixed in 4.8 and 4.7.3 ... 

Cheers,
Ben.

> -- Victor
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
