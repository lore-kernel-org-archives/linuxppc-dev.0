Message-Id: <v04003a08b7a5cb79017f@[24.70.162.12]>
In-Reply-To: <p05100301b7a5c073cc62@[10.0.0.42]>
References: <200108191559.RAA01163@piglet.grunz.lu>
 <200108191559.RAA01163@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 19 Aug 2001 15:08:46 -0500
To: "Timothy A. Seufert" <tas@mindspring.com>, mlan@cpu.lu,
	hozer@drgw.net
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: About TAU (and ICTC)
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:51 PM -0500 8/19/2001, Timothy A. Seufert wrote:
[...]
>But if you think about it, it probably doesn't reduce the total power
>needed to do a given task.  It just spreads the power use over a
>longer period of time.  So you'll use roughly the same amount of
>energy to do one kernel compile no matter what the ICTC setting is;
>it'll just get done slower with ICTC on.
>
>In fact, because programs will generally take longer to run with ICTC
>on, I suspect that ICTC is *less* power efficient than going all-out.
>Only part of the CPU's power use is dynamic (and therefore subject to
>regulation via ICTC).  There's dielectric leakage current, which is
>constant no matter what you do, and, more importantly, plenty of
>clocked circuits which are not shut down by the dynamic power save
>circuitry.  From this one can conclude that power use per unit of
>computation done is likely higher when using ICTC.
[...]

Hmm, I wonder how much thermal-resistive factors would affect this. Y'know,
generally when a circuit is warmer, it's resistance increases, and
subsequently it gets warmer, etc, so depending on how the curves weigh out
(if at all), there might be some hidden power savings in doing calculations
cooler and longer rather than warmer and shorter.

Maybe? I dunno.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
