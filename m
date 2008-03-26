Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080325221209.GB8281@localhost.localdomain>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
	<fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
	<20080321010941.5e4bf9d4@lappy.seanm.ca>
	<20080321070512.GA29010@localhost.localdomain>
	<22b5aa51cfbcba3072020c4897206473@kernel.crashing.org>
	<20080325221209.GB8281@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f789af657dc6001f6337218db90825c5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTS question
Date: Wed, 26 Mar 2008 16:32:28 +0100
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

>>> Well.. stock ticker is the new convention.  IEEE1275 used IEEE
>>> assigned OUI strings (Organization Unique Identifiers).  Often those
>>> are the same as the stock ticker, but not always.
>>
>> Erm, an OUI is a 24-bit number.  I think you're confusing something
>> here.
>
> Yes, I think I am.  I somehow had the impression that in addition to
> the 24-bit OUIs used in MAC addresses, there were also string-form
> OUIs assigned.

Perhaps, I'm not an expert on this organisational stuff (wow, big
understatement).  OF uses only the six-hex-digit form though (with
a prepended 0, to make it unique).

>> Note that a stock symbol needs to be written in uppercase; in 
>> lowercase,
>> it is just a random name that has no collision protection.
>
> Um.. bit too late for that.  AFAIK, uppercase has been used by
> *no-one* for stock ticker derived vendor IDs.

No, it's used quite a lot actually.  Not in DTS files though ;-)

It doesn't matter a lot, lowercase names are perfectly valid, you just
don't get the nice non-collision reassurance you would get if you used
a name in one of the namespaces reserved for that purpose.

It's probably best to not use an uppercase stock symbol if you don't
have approval from the company in question anyway -- we use a
lowercase name (i.e. in the "free-for-all" space) for our messed up
bindings, the companies use an uppercase name (in the stock-ticker
namespace) for their own, incompatible, messed-up bindings, and
everyone is happy.  Or something like that.


Segher
