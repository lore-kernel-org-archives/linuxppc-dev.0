Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20060115071533.GA932@pb15.lixom.net>
References: <Pine.LNX.4.44.0601131118350.19371-100000@gate.crashing.org>
	<20060114192158.GS2491@pb15.lixom.net>
	<20060114234754.GB29766@gate.ebshome.net>
	<20060115071533.GA932@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D052E975-D089-43A0-A834-6FFF518D603D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add FSL SOC library and setup code
Date: Sun, 15 Jan 2006 01:31:18 -0600
To: Olof Johansson <olof@lixom.net>
Cc: Kumar Gala <galak@gate.crashing.org>, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2006, at 1:15 AM, Olof Johansson wrote:

> On Sat, Jan 14, 2006 at 03:47:54PM -0800, Eugene Surovegin wrote:
>> On Sat, Jan 14, 2006 at 01:21:58PM -0600, Olof Johansson wrote:
>>>> +
>>>> +static phys_addr_t immrbase = -1;
>>>
>>> What does immr mean? Maybe a short comment would be good.
>>
>> IMHO, this is not needed because _everybody_ who is working
>> with these chips know what IMMR means. And there cannot be _any_
>> confusion about it. Let's not add useless comments.
>
> I haven't been exposed much yet to embedded 32-bit PPC, I thought at
> first that it was something chip-specific, not an architected feature
> common across the families. I agree, it doesn't really need further
> explanation in this case.

To be clear its a system level architecture feature on Freescale  
SOCs.  It goes by a few different names (immrbar, ccsrbar, eumbar),  
but the purpose is the same.

- kumar
