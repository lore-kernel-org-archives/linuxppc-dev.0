Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CE3FB7BFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 14:59:08 +1100 (EST)
In-Reply-To: <40854686-7CD0-432D-B31C-0D5DF2DADBF9@gmail.com>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
	<86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>
	<4B147086.6070602@gmail.com> <4B14A834.4070907@yahoo.es>
	<40854686-7CD0-432D-B31C-0D5DF2DADBF9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7C6BCD26-7C6D-4562-AA1F-09EBE9253920@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Thu, 3 Dec 2009 05:06:34 +0100
To: Richard Holden <aciddeath@gmail.com>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> you may want to rename the ug_ prefix, it took me a while looking  
>>> back
>>> and forth through the patch to convince myself it wasn't a typo.
>>
>> What's wrong with ug_ ? (ug = (u)sb(g)ecko)
>
> At first look I thought it was a typo of udbg_early_remap. I prefer  
> the longer names although we could use gecko_early_remap unless the  
> gecko prefix conflicts with anything else.

All these names are local to this file.  Shorter names are nicer than
longer names :-)

> If there is not going to be a non usb gecko then there is no need  
> to have usb in the prefix.

There already is a Gecko device that plugs into the memory card slot
as well.  It is older than the USB Gecko, and much more widespread.

It doesn't give you a serial connection, it's memory only.


Segher
