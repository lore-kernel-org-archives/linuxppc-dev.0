Date: Wed, 25 Aug 2004 17:25:54 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: m8xx hang in reboot (fwd)
In-Reply-To: <Pine.LNX.4.61.0408251650510.9890@chef.linux-wlan.com>
Message-ID: <Pine.LNX.4.61.0408251724560.9890@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408251650510.9890@chef.linux-wlan.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The saga continues...  ;-)

I added code to explicitly clear the CHSTPE bit in the DER register.
Didn't make any difference.

I'm stumped.

-M

On Wed, 25 Aug 2004, Mark S. Mathews wrote:

>
> A little more info.  The hang occurs on this line:
>
> 	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
>
> Which is _supposed_ to generate a machine check I believe.
>
> So I guess my next step is to see if somehow the DER got set and we're
> popping into debug mode instead of resetting...
>
> -M
>
> --
>
> Mark S. Mathews
>
> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
> 721-D North Drive          e-mail: mark@linux-wlan.com
> Melbourne, FL 32934        Phone:  321.259.0737
> USA                        Fax:    321.259.0286
>
> ---------- Forwarded message ----------
> Date: Wed, 25 Aug 2004 16:22:00 -0400 (EDT)
> From: Mark S. Mathews <mark@linux-wlan.com>
> To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
> Subject: m8xx hang in reboot
>
> Hey Folks,
>
> I've got an mpc850 based setup running 2.4.27 that, under certain
> circumstances, hangs in the the m8xx_restart() function (instead of
> rebooting)
> when I issue the usermode reboot cmd.
>
> I've traced all through the path and confirmed that yes, it is hanging in
> this
> function.  ;-)
>
> I'm still looking over the databook and what this code does.  Just figured
> I'd
> ask around and see if anyone else has seen this behavior.
>
> Thanks,
> -Mark
>
> --
>
> Mark S. Mathews
>
> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
> 721-D North Drive          e-mail: mark@linux-wlan.com
> Melbourne, FL 32934        Phone:  321.259.0737
> USA                        Fax:    321.259.0286
>
>
>

--

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
