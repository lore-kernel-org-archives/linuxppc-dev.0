MIME-Version: 1.0
Message-Id: <39056609.13496@mta2>
Date: Tue, 25 Apr 2000 17:31:53 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: memory map
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Steve Tarr wrote:
>
>
>> This IMMR  for the MPC8260 is VERY  tricky,
>
>I didn't think so.  The only thing different is that it isn't stored
>in a special register, so you have to know the current IMMR to change
>to a different one. You can read the default setting from the
>config word or boot rom, and then change it if you wish.
>
this should be done as early as possible unless want to set or copy those values again from old to new.The value is really unimportant
if decide to map it with  BAT.
ADS manual say this should be 0x0470-0000 with no obvious reason.
At least it is not mandatary.My pilot board cannot read hwconfig
from flash(it took me much time to find this before learned it from Motorola web site),the default IMMR after power on is 0x0f00-0000.
I choose to map it to 0xf000-0000 with  BAT.
>You have to get the default word from someplace, and that is either
>the application choice from the boot rom or by asserting RSTCONF and
>using a default when there isn't a boot rom.
>
>I think the implementation is pretty slick, especially when you look
>at the multiprocessor implementation.
>
>Just because Motorola screwed up one of their reference boards (again),
>doesn't mean it can't work well for others.  The purpose of these reference
>boards is to demonstrate the ease of using a processor, and I am just
>amazed they consistently build the most difficult to use and unreliable
>platform to do that.  Fortunately, there are other choices.
Any other board ? I know there is one from EST with no FCC.
>
>
>	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
