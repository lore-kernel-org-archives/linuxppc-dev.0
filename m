Message-Id: <200007301648.RAA16700@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 17:48:48 +0100
Subject: Re: CONFIG_PPC != Mac
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        "Michel Dnzer" <daenzerm@student.ethz.ch>
CC: Tony Mantler <nicoya@apia.dhs.org>, Tom Rini <trini@kernel.crashing.org>,
        Dan Malek <dan@netx4.com>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset=""
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Sun, Jul 30, 2000,  Geert Uytterhoeven wrote:
> On Sun, 30 Jul 2000, Michel [iso-8859-1] Dänzer wrote:
>> Geert Uytterhoeven wrote:
>> > The Master PPC Penguin decided to no longer allow to build machine specific
>> > kernels, but treat PowerMac/PReP/MTX/CHRP as one big machine type
>> > (`CONFIG_ALL_PPC').
[snip]
> Personally I'd more like a configuration where you can select whatever you
> want of
>
>   - PowerMac (CONFIG_PMAC)
>   - PReP (CONFIG_PREP)
>   - MTX (CONFIG_MTX)
>   - CHRP (CONFIG_CHRP)
>   - Gemini (CONFIG_GEMINI)
>   - EST8260 (CONFIG_EST8260)
>   - APUS (CONFIG_APUS)
>
> with of course some extra logic to prevent illegal combinations.

This would definitely get my vote too.  There are too many cases where you
can enable conflicting build options at present - it causes much
frustration.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
