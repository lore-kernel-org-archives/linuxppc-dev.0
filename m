In-Reply-To: <1083251690.16941.1.camel@veena.timesys>
References: <1083251690.16941.1.camel@veena.timesys>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A5AD09EC-9A30-11D8-A9B8-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: MPC8560 FCCs
Date: Thu, 29 Apr 2004 17:57:53 -0500
To: Jason McMullan <jason.mcmullan@timesys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jason,

I've been able to do this on an 8560 ADS, however I'm setting the
jumpers such that the PHYs are in 'legacy' mode.  This means that we
use GPIO pins to talk to them rather than the TSEC MDIO bus.

- kumar

On Apr 29, 2004, at 10:14 AM, Jason McMullan wrote:

>
> Out of curiosity, has *anyone* gotten the MPC8560's (rev 1 OR Rev 2)
> FCCs to generate proper ethernet frames?
>
> I am having a lot of trouble with them.
>
> The TSECs work just fine.
>
> --
> Jason McMullan <jason.mcmullan@timesys.com>
> TimeSys Corporation
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
