Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F2780B70AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 06:40:14 +1000 (EST)
Message-ID: <1340051997.2372.27.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Jun 2012 06:39:57 +1000
In-Reply-To: <CAErSpo4pDOigbvF3SPzOUqx79d_-8yHWrc8TsWChG9indB+k_A@mail.gmail.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <1338959744.7150.153.camel@pasglop>
 <CAErSpo4pDOigbvF3SPzOUqx79d_-8yHWrc8TsWChG9indB+k_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@au1.ibm.com>,
 Ben Collins <ben.c@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-18 at 09:23 -0600, Bjorn Helgaas wrote:
> Ooh, sorry about that.  Who's going to push this fix?  I don't see it
> in Linus' tree yet.  If you want me to, please forward me the original
> patch. 

I want to double check something. We are still printing something wrong
in the kernel log, so it looks like we have some incorrect carry in some
arithmetic happening somewhere.

Cheers,
Ben.
