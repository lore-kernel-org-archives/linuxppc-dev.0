To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Hymod board support and related changes ... 
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org>
   of "Tue, 28 May 2002 12:26:52 MST." <20020528192652.GM1295@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 May 2002 12:10:35 +1000
Message-ID: <23598.1022638235@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 28 May 2002 12:26:52 -0700, Tom Rini <trini@kernel.crashing.org> writes:
>On Tue, May 28, 2002 at 03:48:35PM +1000, Murray Jensen wrote:
>> Hymod board support and related changes ...
>>
>> - Hymod board support
>> - 8260 fcc_enet: more flexible (or at least readable) approach to
>>   configuring i/o pins
>> - 8260 fcc_enet: support different PHY interrupt "vector"s for each FCC
>> - 8260 setup: fixed ppcboot jump address; should be 0x...110 not 0x...104
>> - 8260 setup: turn off interrupts before jumping to the boot rom
>
>Can you split this up into logical patches?

OK

>Also, instead of testing
>TQM8260 || HYMOD for PPCBoot, why don't we just add in something like:
>if [ "$CONFIG_TQM8260" = "y" -o  "$CONFIG_HYMOD" = "y" \
>	-o "$CONFIG_TQM8xx" = "y" ] ;then
>   define_bool CONFIG_PPCBOOT y
>fi
>
>And use that.

Agreed. I will re-submit this patch. I will spend a bit of time on it, to see
if there are any other "generic" ppcboot configurations that could be rolled
into this. Cheers!
								Murray...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
