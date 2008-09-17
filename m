Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: demuxing irqs
Date: Wed, 17 Sep 2008 10:54:48 -0700
In-Reply-To: <9e4733910809170709i30977945mc236ed844a26b62e@mail.gmail.com>
References: <20080916121740.GA9970@oksana.dev.rtsoft.ru><20080916131203.GA21641@oksana.dev.rtsoft.ru><9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com><20080916141422.GA29888@oksana.dev.rtsoft.ru><9e4733910809160724x693c5af9y8df2f609e79f5005@mail.gmail.com><20080916174935.GA13142@ld0162-tx32.am.freescale.net><9e4733910809161132j3b0ff194hd60fcdf489fb19e4@mail.gmail.com><20080916214210.GA15987@oksana.dev.rtsoft.ru><9e4733910809161508m3a94baf1g818be7247439848e@mail.gmail.com><20080917125600.GA20931@oksana.dev.rtsoft.ru>
	<9e4733910809170709i30977945mc236ed844a26b62e@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Jon Smirl" <jonsmirl@gmail.com>,
	<avorontsov@ru.mvista.com>
Message-ID: <20080917175448.C5A60108006C@mail105-wa4.bigfish.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It doesn't seem to me that the problem (hierarchical interrupts) is one
that only happens with GPIOs, so why treat them specially?  Since there
seems to be a reasonable solution that keeps them in a
separate namespace, that seems like the better way to go...

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Jon
Smirl
> Sent: Wednesday, September 17, 2008 7:09 AM
> To: avorontsov@ru.mvista.com
> Cc: Scott Wood; linuxppc-dev; Roland Dreier
> Subject: Re: demuxing irqs
> =

> Both solutions can be implemented. This is really a question of style.
> Since this impacts all of the PowerPC implementations we should get
> feedback from more people  I'll go along with whatever the group
> wants.
> =

> The basic question is: Should GPIOs and VIRQs each have their own
> namespace, or should there be a single unified namespace?
> =

> --
> Jon Smirl
> jonsmirl@gmail.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
