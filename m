From: Alan Mimms <alanm@unforgettable.com>
Date: Fri, 17 Mar 2000 17:23:38 GMT
Message-ID: <20000317.17233800@alanm.penguinpowered.com>
Subject: Re: What is the catch with IDMA on MPC860?
To: "Geir Frode Raanes" <geirfrs@invalid.ed.ntnu.no>
CC: "Richard Hendricks" <ra6353@email.sps.mot.com>,
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.BSF.4.10.10003171722430.93013-100000@invalid.ed.ntnu.no>
References: <Pine.BSF.4.10.10003171722430.93013-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Regarding the "where does the manual say that the performance stinks"
comment: even though people like Richard are VERY forthcoming with
"issues" with chips (THANKS Richard), I doubt a company like MOT will
EVER admit in a manual or other official document they built something
that stinks even a little bit.  See the MPC801 for an example of this
where virtually EVERYTHING about the chip stinks (including the crappy
inaccurate manual) and nothing is ever said in written form to that
effect.  (For those unused to my cynical style, I love MOT and my
company has even made a bunch of money selling devices built on the
MPC801.  But they are NOT perfect - as I'm sure Richard and numerous
will attest - and they will rarely admit it in writing.)

a

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 3/17/00, 9:02:22 AM, "Geir Frode Raanes" <geirfrs@invalid.ed.ntnu.no>
wrote regarding Re: What is the catch with IDMA on MPC860?:


> On Fri, 17 Mar 2000, Richard Hendricks wrote:

> >
> >
> > Geir Frode Raanes wrote:
> > >
> > > Revision C or later of the '860 will even perform
> > > a single-address _burst_ transfer on IDMA channel 1.
> > > This I would love to do from our in-house designed
> > > frame grabber to main memory. Then I could avoid
> > > disabling all interrupts while bursting. Meaning
> > > I could still catch run-away situations on a
> > > time-out basis. Today things simply lock up...

> > The biggest complaint I hear is the performance stinks.
> > Which it does, since it is really a software based DMA
> > algorithm running on the CPM.

> Possibely. But where does the manual say that the
> performance stinks? It should be documented somewhere.

> > I *think* you mean Single-buffer burst flyby mode.

> That is correct. I just quoted the subtitle of figure 20-15.
> But the chapter is named Single-buffer burst flyby mode.
> The following figure numbers are collected from the current
> version of the MPC860UM user manual in PDF form @ motorola.

> Figure 14-5:  Single-Beat Cycle Basic Timing Zero Wait States
>               Two clock cycles per bus cycle.

> Figure 14-12: Burst-Read Cycle with Zero Wait state.
>               Five clock cycles per four words burst cycle.

> Figure 20-15: Single Buffer/Address IDMA1 Burst Timing.
>               /TA alternating resulting in one waitstate per
>               word and thus nine clock cycles per four words
>               burst cycle.

> Figure 14-14: Burst-Read Cycle with Wait States between Beats.
>               Would have been identical to figure 20-15
>               with identical /TA pattern.


> Now, the question is - what controls the /TA line?
> Will I get full speed if actively driving the /TA line low for
> the duration of the IDMA1 burst cycle? Or for that matter in the
> Single-address/Single-cycle Fly-by transfer of figure 20-10?
> The subtitles states that /TA is externally generated. What then
> stops me from running the IDMA bus cycle with normal PIO mode
> timing as per figure 14-5?


> Figure 20-10: /SDACK timing diagram
>               Single-Address Peripheral write
>               __EXTERNALLY GENERATED /TA__


> --
>   ******************************************************
>   Never ever underestimate the power of human stupidity.
>   -Robert Anson Heinlein

>               GeirFRS@invalid.and.so.forth
>   ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
