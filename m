Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 9BE002BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 23:37:42 +1000 (EST)
Date: Wed, 6 Oct 2004 09:30:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20041005202017.6DC7BC1430@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0410060926320.8416@dell.enoriver.com>
References: <20041005202017.6DC7BC1430@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 5 Oct 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0410051543230.3549@localhost.localdomain> you wrote:
>>
>> that's definitely understandable.  it's just potentially confusing to
>> have a structure's reserved chunks declared as some combination of
>> uchar, ushort, uint and/or ulong, when it's obviously more
>> comprehensible to make each reserved chunk a standard array of char
>> whose size is obvious at a glance.
>
> Actually this might not be confusing, but making the code  easier  to
> read,  to  understand,  and  maybe  one day to extend - remember that
> these struct definitions are direct translations of Motorola provided
> documentation - and I tend to  believe  that  the  chip  manufacturer
> knows  more about the internals of his chips than you or me. One day,
> a "uint reserved_xxx;" may turn into a new, shiny 32 bit register.

from "Documentation/SubmittingPatches", at the very end:

   4) Don't over-design.

   Don't try to anticipate nebulous future cases which may or may not
   be useful:  "Make it as simple as you can, and no simpler"

it seems that, if that's good advice for patches, it should be good 
advice for the code proper.  i do appreciate your point, but if at 
some point, a shiny new register suddenly appears, that strikes me as 
a significant enough change that mods to the header file shouldn't be 
considered a big deal.

anyway, just my $0.02.

rday
