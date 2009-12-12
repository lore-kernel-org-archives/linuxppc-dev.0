Return-Path: <albert_herranz@yahoo.es>
Received: from smtp107.mail.ukl.yahoo.com (smtp107.mail.ukl.yahoo.com
	[77.238.184.39]) by ozlabs.org (Postfix) with SMTP id 690C8B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 11:18:46 +1100 (EST)
Message-ID: <4B22E164.1070606@yahoo.es>
Date: Sat, 12 Dec 2009 01:18:44 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH v2 0/6] powerpc: nintendo wii support
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40912111552m28d1cc40we072cebef675f100@mail.gmail.com>
In-Reply-To: <fa686aa40912111552m28d1cc40we072cebef675f100@mail.gmail.com>
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
> Hi Albert.
> 

Hi,

> I'm ready to pick up your Gamecube and Wii patch sets for merging.
> You seem to have 4 distinct patch sets.  What order do they need to be
> applied in, and what kernel version are they based on?
> 

The patches were based on 2.6.32-rc8.
The apply order should be:

v2 powerpc: nintendo gamecube support
 powerpc: gamecube/wii: usbgecko bootwrapper console support
 powerpc: gamecube: device tree
 powerpc: gamecube: bootwrapper bits
 powerpc: gamecube/wii: introduce GAMECUBE_COMMON
 powerpc: gamecube/wii: declare as non-coherent platforms
 powerpc: gamecube/wii: do not include PCI support
 powerpc: gamecube/wii: udbg support for usbgecko
 powerpc: gamecube/wii: flipper interrupt controller support
 powerpc: gamecube: platform support
 powerpc: gamecube: default config

v2 powerpc: nintendo wii support
 powerpc: wii: device tree
 powerpc: wii: bootwrapper bits
 powerpc: broadway processor support
 powerpc: wii: hollywood interrupt controller support
 powerpc: wii: platform support
 powerpc: wii: default config

v4 rework of usbgecko-based early debug
 powerpc: reserve fixmap entries for early debug
 powerpc: gamecube/wii: early debugging using usbgecko

v2 powerpc: wii: mem2 as ram support
 wii: bootwrapper: add fixup to calc useable mem2
 wii: use both mem1 and mem2 as ram
 powerpc: allow ioremap within reserved memory regions
 powerpc: wii: allow ioremap within the memory hole

But if you prefer it, I can re-send them as one patch set again rebased on top of v2.6.32.

> Thanks,
> g.

Thanks,
Albert
