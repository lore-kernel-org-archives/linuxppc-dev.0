Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FC6ADE229
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 22:32:22 +1100 (EST)
In-Reply-To: <fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
	<fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <174ea0cfa5f5789329d122073cb8bd47@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTS question
Date: Fri, 21 Mar 2008 12:31:40 +0100
To: "Grant Likely" <grant.likely@secretlab.ca>
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

>>  I wondered about this. Since the AD from Analog Devices is built into
>>  the part number, I didn't know if it was needed. And analog-devices 
>> is
>>  pretty long ;)
>>
>>  But I am willing to put it in if it is necessary.
>
> Convention is to use the stock ticker symbol.  If the company is
> private and has no stock ticker symbol, then the company name should
> be used.

The three forms are, in order of preference:

0NNNNNN with NNNNNN the (hexadecimal) OUI;
ABCDE (uppercase stock symbol);
abcde (any name that cannot be confused for the other two forms;
        usually by making it lowercase).

The preference is in this order because OUI _is_ unique, stock ticker
will likely be unique (but not always!), and for random names there
is no guarantee or assurance at all.

I've never actually seen the OUI used, it's not very user-friendly ;-)


Segher
