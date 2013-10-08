Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 527A12C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:31:40 +1100 (EST)
Message-ID: <1381275075.645.251.camel@pasglop>
Subject: Re: [PATCH 1/2][v2] pci: fsl: derive the common PCI driver to
 drivers/pci/host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 09 Oct 2013 10:31:15 +1100
In-Reply-To: <1381274440.7979.309.camel@snotra.buserror.net>
References: <1380531175-14836-1-git-send-email-Minghuan.Lian@freescale.com>
 <CAErSpo7LXqXmrw1gPwKHsJkKaAcDr2W_+tcC8b9T_5Mab1Arnw@mail.gmail.com>
 <1381272382.7979.292.camel@snotra.buserror.net>
 <CAErSpo76_w+wK76m73kkdYS1PouhYcGfZus_FYF5E2FHJTA6gQ@mail.gmail.com>
 <1381274440.7979.309.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-08 at 18:20 -0500, Scott Wood wrote:
> > So I'll apply these given an ack from the powerpc folks.
> 
> ACK this patch.  The second one I'd like to see broken up into
> digestible chunks so I can better review it.

Bjorn, for such FSL-only stuff, Scott ack is enough, don't wait for
mine :-)

Cheers,
Ben.
