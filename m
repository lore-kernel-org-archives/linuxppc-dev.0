From: duncanp@research.canon.com.au
Date: Sat, 13 May 2000 15:18:01 +1000 (EST)
Subject: Re: How to get rom code to go on FADS?
To: "Dan A. Dickey" <ddickey@charter.net>
Cc: Richard Hendricks <richard.hendricks@motorola.com>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <391C3945.9E0A439F@charter.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-Id: <20000513041750.78D9E3C971@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 12 May, Dan A. Dickey wrote:
>

[..snip..]

>
> However, the 8xxROM code does not run *at all* without the ADI &
> mpc8bug.
> In fact, I'm pretty sure that no instruction at all are being
> executed...
> (I've modified 8xxrom code to setup IMMR, BR1/OR1 to point at BCSR;
>  and then can toggle the AUX LAMP led - all this as about the first
>  thing in the reset code).
> (And, the above does toggle the AUX led just nicely - *WITH* adi &
> mpc8bug).
>
> But, when I exit mpc8bug95 and disconnect the ADI ribbon cable from the
> FADS and toggle the power on the FADS; about all I get is the RUN, 5V,
> SDRAM, DRAM, and FLASH leds on.  No toggling AUX; nothing else for
> as long as I leave it on.  Kind of like its in a constant reset
> condition.
>

This reminds me of something silly i've done in the past - Have you
remembered to disable the hardware watchdog?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
