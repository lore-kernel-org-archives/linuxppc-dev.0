Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id DFB16DDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:49:28 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so93312ana
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 09:49:27 -0800 (PST)
Message-ID: <fa686aa40711090949n3fbb78dax59379c4c42293552@mail.gmail.com>
Date: Fri, 9 Nov 2007 10:49:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 12/13] [POWERPC] Promess Motion-PRO DTS
In-Reply-To: <20071106224200.GE31367@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200634.10913.6248.stgit@hekate.izotz.org>
	<20071106224200.GE31367@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Nov 06, 2007 at 09:06:34PM +0100, Marian Balakowicz wrote:
> [snip]
> > +             // PSC2 in spi master mode
> > +             spi@2200 {              // PSC2
> > +                     compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
> > +                     cell-index = <1>;
>
> From your description, this is an incorrect usage of cell-index - it
> should *only* be used to index into SoC shared registers; never for
> logical numbering.

Actually, this one is correct.  PSCs are numbered in the data sheet
from PSC1 to PSC6; so cell-index = <0> for PSC1, cell-index = <1> for
PSC2, etc.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
