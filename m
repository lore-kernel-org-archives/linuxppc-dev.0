Date: Mon, 10 Feb 2003 10:06:02 -0500
From: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA out/External Monitor on ibook 2
Message-ID: <20030210150602.GA9933@haar.ae.gatech.edu>
References: <Pine.LNX.4.33.0302101055260.10914-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <Pine.LNX.4.33.0302101055260.10914-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 10, 2003  05:06 Monday Michael Schmitz wrote:
> > > case 2: Monitor not connected at boot up
>
> Someone lately posted a message detailing the problem (either here or on
> debian-powerpc): the hsync and vsync pulses appear to be OK (correct
> frequency) but have a phase jitter.

Unless somebody else posted it too, that would be me. And I now realise
that it was based on your suggestion (on debian-powerpc) a year back!
Owen asked: How was it using OFFB? The phase is steady with the OFFB.

> Does that ring a bell with anyone
> here? Does anyone know which PLL setting the hsync position is derived
> from?
>
> 	Michael

Is it possible that the lcd and crt *have to be* on different
controllers? From what I understand,  OF and OSX set it up that way but we
don't. As I have no documentation, this is just  a conjecture.
Still I would like to do just that. But I am constrained by the lack of
documentation. Pointers anybody? Maybe people who desire a dual-head would
like to help :)

regards,
-manuj

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
