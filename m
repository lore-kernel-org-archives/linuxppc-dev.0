Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080321070512.GA29010@localhost.localdomain>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
	<fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
	<20080321010941.5e4bf9d4@lappy.seanm.ca>
	<20080321070512.GA29010@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22b5aa51cfbcba3072020c4897206473@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTS question
Date: Fri, 21 Mar 2008 12:35:39 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Convention is to use the stock ticker symbol.  If the company is
>>> private and has no stock ticker symbol, then the company name should
>>> be used.
>>
>> I didn't know that. ADI it is then.
>
> Well.. stock ticker is the new convention.  IEEE1275 used IEEE
> assigned OUI strings (Organization Unique Identifiers).  Often those
> are the same as the stock ticker, but not always.

Erm, an OUI is a 24-bit number.  I think you're confusing something
here.

> Stock ticker is a good choice for new things, but for anything from a
> vendor which has existing 1275 bindings for its products, I think we
> should keep the original assigned OUI, even if it differs from the
> stock ticker.

Yes, when there is an existing binding, obviously you should use what
it says (unless that binding is *completely* broken).  Compatibility
is good.

Note that a stock symbol needs to be written in uppercase; in lowercase,
it is just a random name that has no collision protection.


Segher
