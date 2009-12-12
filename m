Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 90EC3B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 17:48:21 +1100 (EST)
Received: by yxe9 with SMTP id 9so1610707yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 22:48:19 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B22E164.1070606@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40912111552m28d1cc40we072cebef675f100@mail.gmail.com>
	<4B22E164.1070606@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 23:47:58 -0700
Message-ID: <fa686aa40912112247g7562349eyc432b0d070de416e@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] powerpc: nintendo wii support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 11, 2009 at 5:18 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Grant Likely wrote:
>> Hi Albert.
>>
>
> Hi,
>
>> I'm ready to pick up your Gamecube and Wii patch sets for merging.
>> You seem to have 4 distinct patch sets. =A0What order do they need to be
>> applied in, and what kernel version are they based on?
>>
>
> The patches were based on 2.6.32-rc8.
> The apply order should be:
>
> v2 powerpc: nintendo gamecube support
> =A0powerpc: gamecube/wii: usbgecko bootwrapper console support
> =A0powerpc: gamecube: device tree
> =A0powerpc: gamecube: bootwrapper bits
> =A0powerpc: gamecube/wii: introduce GAMECUBE_COMMON
> =A0powerpc: gamecube/wii: declare as non-coherent platforms
> =A0powerpc: gamecube/wii: do not include PCI support
> =A0powerpc: gamecube/wii: udbg support for usbgecko
> =A0powerpc: gamecube/wii: flipper interrupt controller support
> =A0powerpc: gamecube: platform support
> =A0powerpc: gamecube: default config
>
> v2 powerpc: nintendo wii support
> =A0powerpc: wii: device tree
> =A0powerpc: wii: bootwrapper bits
> =A0powerpc: broadway processor support
> =A0powerpc: wii: hollywood interrupt controller support
> =A0powerpc: wii: platform support
> =A0powerpc: wii: default config
>
> v4 rework of usbgecko-based early debug
> =A0powerpc: reserve fixmap entries for early debug
> =A0powerpc: gamecube/wii: early debugging using usbgecko
>
> v2 powerpc: wii: mem2 as ram support
> =A0wii: bootwrapper: add fixup to calc useable mem2
> =A0wii: use both mem1 and mem2 as ram
> =A0powerpc: allow ioremap within reserved memory regions
> =A0powerpc: wii: allow ioremap within the memory hole
>
> But if you prefer it, I can re-send them as one patch set again rebased o=
n top of v2.6.32.

Hmmm..  Looks like there are some inconsistencies in here.  For
example, the 7th patch of the first series, and the 2nd patch of the
3rd series are different version of the same thing.  The whole thing
doesn't apply as is.  Reposting the current state of the whole series
would help.  Add any acked-by lines that you've received from Ben,
Segher, or anybody else before you repost so I can see the full
current state.

Thanks
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
