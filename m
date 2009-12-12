Return-Path: <albert_herranz@yahoo.es>
Received: from smtp145.mail.ukl.yahoo.com (smtp145.mail.ukl.yahoo.com
	[77.238.184.76]) by ozlabs.org (Postfix) with SMTP id 062B2B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 20:35:50 +1100 (EST)
Message-ID: <4B2363EF.2070009@yahoo.es>
Date: Sat, 12 Dec 2009 10:35:43 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH v2 0/6] powerpc: nintendo wii support
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40912111552m28d1cc40we072cebef675f100@mail.gmail.com>
	<4B22E164.1070606@yahoo.es>
	<fa686aa40912112247g7562349eyc432b0d070de416e@mail.gmail.com>
In-Reply-To: <fa686aa40912112247g7562349eyc432b0d070de416e@mail.gmail.com>
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

Grant Likely wrote:
> On Fri, Dec 11, 2009 at 5:18 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> Grant Likely wrote:
>>> Hi Albert.
>>>
>> Hi,
>>
>>> I'm ready to pick up your Gamecube and Wii patch sets for merging.
>>> You seem to have 4 distinct patch sets.  What order do they need to be
>>> applied in, and what kernel version are they based on?
>>>
>> The patches were based on 2.6.32-rc8.
>> The apply order should be:
>>
>> v2 powerpc: nintendo gamecube support
>>  powerpc: gamecube/wii: usbgecko bootwrapper console support
>>  powerpc: gamecube: device tree
>>  powerpc: gamecube: bootwrapper bits
>>  powerpc: gamecube/wii: introduce GAMECUBE_COMMON
>>  powerpc: gamecube/wii: declare as non-coherent platforms
>>  powerpc: gamecube/wii: do not include PCI support
>>  powerpc: gamecube/wii: udbg support for usbgecko
>>  powerpc: gamecube/wii: flipper interrupt controller support
>>  powerpc: gamecube: platform support
>>  powerpc: gamecube: default config
>>
>> v2 powerpc: nintendo wii support
>>  powerpc: wii: device tree
>>  powerpc: wii: bootwrapper bits
>>  powerpc: broadway processor support
>>  powerpc: wii: hollywood interrupt controller support
>>  powerpc: wii: platform support
>>  powerpc: wii: default config
>>
>> v4 rework of usbgecko-based early debug
>>  powerpc: reserve fixmap entries for early debug
>>  powerpc: gamecube/wii: early debugging using usbgecko
>>
>> v2 powerpc: wii: mem2 as ram support
>>  wii: bootwrapper: add fixup to calc useable mem2
>>  wii: use both mem1 and mem2 as ram
>>  powerpc: allow ioremap within reserved memory regions
>>  powerpc: wii: allow ioremap within the memory hole
>>
>> But if you prefer it, I can re-send them as one patch set again rebased on top of v2.6.32.
> 
> Hmmm..  Looks like there are some inconsistencies in here.  For
> example, the 7th patch of the first series, and the 2nd patch of the
> 3rd series are different version of the same thing.  The whole thing
> doesn't apply as is.  Reposting the current state of the whole series
> would help.  Add any acked-by lines that you've received from Ben,
> Segher, or anybody else before you repost so I can see the full
> current state.
> 

The 7th patch of the first series is "normal" udbg support.
The 2nd patch of the third series is "early" udbg support.

I'll repost the whole series later adding the Acked-by lines. I'll send them as PATCH v2 (not RFC PATCH).

I'll add a minor correction for "powerpc: gamecube/wii: early debugging using usbgecko" suggested by Segher (use Vp=0 instead of Vp=1 in the early mapping).
And code to "powerpc: wii: platform support" to turn off the front blue led and sensor bar on boot.

> Thanks
> g.
> 

Thanks,
Albert
