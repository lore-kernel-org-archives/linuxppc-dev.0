Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EEFFF679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 00:29:41 +1000 (EST)
In-Reply-To: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
References: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fd3c79c765947d1c1ab4af33e463850a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Jun 2005 09:29:39 -0500
To: "Allen Curtis" <acurtis@onz.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> I'm trying to stay away from basing things on the structure.  Since
>> the offsets are truly fixed I see not reason to try to make sure that
>> the immap structure is always correct for all cases.  Hopefully this
>> will end up removing the need to ifdef the immap structure as we go
>> forward.
>>
>
> I am not sure I understand the purpose of each access method. How is
> the immap structure used vs. the platform resources list? Going half
> way without a clear distinction of purpose will just confuse the
> matter. (my opinion)

Agreed, I guess what I mean is going forward drivers should contain 
their own structure defn.

>> pq2_* instead of mpc82xx_ (8240/1/5 is not handled here) or cpm2_
>> (85xx has cpm2).
>
> I used the name CPM2 because that is how all the files are now renamed.
> Based on the #ifdef in your patch, you can see that 82xx and 83xx use
> the same device definitions. Lets change the name.

Sure but...  I'll change the file names to pq2_ which is what makes the 
most sense at the end of they.

- kumar
