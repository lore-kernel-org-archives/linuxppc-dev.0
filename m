Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 819D6B700C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 08:46:49 +1000 (EST)
Message-ID: <1340059508.2372.42.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <ben.c@servergy.com>
Date: Tue, 19 Jun 2012 08:45:08 +1000
In-Reply-To: <0F5B9B19-CC65-4DF0-92FB-C34767C42E80@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <1338959744.7150.153.camel@pasglop>
 <CAErSpo4pDOigbvF3SPzOUqx79d_-8yHWrc8TsWChG9indB+k_A@mail.gmail.com>
 <1340051997.2372.27.camel@pasglop>
 <0F5B9B19-CC65-4DF0-92FB-C34767C42E80@servergy.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-18 at 16:04 -0500, Ben Collins wrote:
> On Jun 18, 2012, at 3:39 PM, Benjamin Herrenschmidt wrote:
> 
> > On Mon, 2012-06-18 at 09:23 -0600, Bjorn Helgaas wrote:
> >> Ooh, sorry about that.  Who's going to push this fix?  I don't see it
> >> in Linus' tree yet.  If you want me to, please forward me the original
> >> patch. 
> > 
> > I want to double check something. We are still printing something wrong
> > in the kernel log, so it looks like we have some incorrect carry in some
> > arithmetic happening somewhere.
> 
> Can we at least get this patch in to get things working again? It's still a regression either way.

Sure, I'm only just back from my sick leave, I haven't had a chance to
go through the pending patches yet.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> > 
> 
> --
> Ben Collins
> Servergy, Inc.
> (757) 243-7557
> 
> CONFIDENTIALITY NOTICE: This communication contains privileged and/or confidential information; and should be maintained with the strictest confidence. It is intended solely for the use of the person or entity in which it is addressed. If you are not the intended recipient, you are STRICTLY PROHIBITED from disclosing, copying, distributing or using any of this information. If you received this communication in error, please contact the sender immediately and destroy the material in its entirety, whether electronic or hard copy.
