Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1175278427.3122.164.camel@pmac.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
	<1175276728.3122.161.camel@pmac.infradead.org>
	<3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
	<1175278427.3122.164.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <88b09b41faaba7e39189bbaf5b61acc3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
Date: Sat, 31 Mar 2007 17:27:12 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Maybe you should use a bootwrapper, instead.
>>
>> It doesn't make sense to duplicate lots of firmware
>> and bootloader/bootwrapper functionality in the kernel
>> just for kexec.  (Or to do that at all, really).
>
> kexec has a --devicetreeblob option, if we need to resort to that.

That would seem a good option, yes.

> And we're not talking about "lots of functionality". It's just a case 
> of
> ignoring the memory which is mentioned in the device-tree.

Yes, every single little addition isn't very big, sure.
It all accumulates though and at some point it will be
too much.  My tolerances are lower than yours I guess ;-)


Segher
