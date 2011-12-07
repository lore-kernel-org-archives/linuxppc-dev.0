Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C78411007D5
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 09:03:12 +1100 (EST)
Message-ID: <1323295383.12793.3.camel@pasglop>
Subject: Re: ibm_newemac tx problem with jumbo frame enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Date: Thu, 08 Dec 2011 09:03:03 +1100
In-Reply-To: <CAD6p20chCnh+PN5ekPz20BJQMdTaisb5toLA9rySaYJTeivRfQ@mail.gmail.com>
References: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
 <1322198727.32635.25.camel@pasglop>
 <CAD6p20chCnh+PN5ekPz20BJQMdTaisb5toLA9rySaYJTeivRfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-07 at 13:35 +0530, Prashant Bhole wrote:
> Still couldn't find anything like fifo overflow...
> I noticed one more thing, this problem happens only when mtu size on
> the initiator (the other end) is set to 4088, regardless of any mtu
> size set for EMAC. 

Did you check all the registers that may carry errors ? Nothing showed
up ? Did you check that things like Pause frames were properly
negociated on both sides ? Tried playing with the pause and FIFO
thresholds ?

Other than using the tx timeout to perform resets I don't see a good way
to fix that problem.

Cheers,
Ben.
