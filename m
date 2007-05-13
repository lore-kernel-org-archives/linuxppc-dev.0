Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4647098D.9050901@gmail.com>
References: <20070510200237.GA19756@mag.az.mvista.com>	<20070510200859.GL19756@mag.az.mvista.com>	<20070510233747.GC27188@localhost.localdomain>
	<c3bcf08004bf1d35292b8a5661e6a6e6@kernel.crashing.org>
	<46465511.3090000@gmail.com>
	<70c9e7f82599a85ba1ae974e11db1d8f@kernel.crashing.org>
	<4647098D.9050901@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <feb0a7acbb464e8fb4977e58f2d2d005@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Sun, 13 May 2007 16:45:51 +0200
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Not bad at all -- it is trivial to decode _if_ you know
>> how it is encoded.  You cannot tell by looking at the
>> property data only.  What is [44 54 53 00] -- just some
>> bytes, or the integer 0x44545300, or the string "DTS"?
>> You cannot tell.
>
> OK.  I was coming from the u-boot "fdt print" command.  We do a pretty 
> good job of guessing the print format (byte/word/long/string/strings), 
> but this would fail the detection circuitry and be printed as a byte 
> array [00, 00, 00, 05, 44, 54, ...] (the default format) because it 
> takes a-priori knowledge to print it in the original input format.  
> Not quite as pretty, but NBD.

Yes, every possible way of displaying property contents
is based on heuristics, some better than others -- taking
the property name (and perhaps some other context) into
account helps a lot.  Also, hardly any property is not
an array of 32-bit ints or an array of strings.


Segher
