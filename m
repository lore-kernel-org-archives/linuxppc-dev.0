Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Mar 2008 18:05:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: DTS question
Message-ID: <20080321070512.GA29010@localhost.localdomain>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
	<fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
	<20080321010941.5e4bf9d4@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080321010941.5e4bf9d4@lappy.seanm.ca>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 01:09:41AM -0400, Sean MacLennan wrote:
> On Thu, 20 Mar 2008 22:34:21 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
> 
> > Convention is to use the stock ticker symbol.  If the company is
> > private and has no stock ticker symbol, then the company name should
> > be used.
> 
> I didn't know that. ADI it is then.

Well.. stock ticker is the new convention.  IEEE1275 used IEEE
assigned OUI strings (Organization Unique Identifiers).  Often those
are the same as the stock ticker, but not always.

Stock ticker is a good choice for new things, but for anything from a
vendor which has existing 1275 bindings for its products, I think we
should keep the original assigned OUI, even if it differs from the
stock ticker.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
