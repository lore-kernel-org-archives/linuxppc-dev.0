Date: Mon, 4 Jan 1999 10:04:35 -0800 (PST)
From: Peter Abrahamsen <p1rabbit@halcyon.com>
To: Brad Midgley <brad@pht.com>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
In-Reply-To: <Pine.LNX.3.95.990104100936.8496A-100000@pacific.pht.com>
Message-ID: <Pine.GUL.4.05.9901040959550.4552-100000@coho.halcyon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 4 Jan 1999, Brad Midgley wrote:

> that's the SAME drive that aborts for me in 2.2.0p4. mine is also
> connected to mesh. my 2.1.30 identifies it as: 
> Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G

Yep, that's the one.

> i don't see it blacklisted. something just makes it want to abort now. the
> scary thing about this is this drive ships STANDARD in 1gig 7500's. that's
> a lot of computers that suddenly can't run linux. 

As well as 7600s :)

> peter, did you ever try booting mklinux? it always got an abort when it
> came across that drive... 

Nope, never tried. Vger 2.1.130 from CVS a/o a few days ago works fine.
I've found that the other problem I had was caused by having a serial.o
module, which my system automatically loaded when it ran setserial.
Please address or cc responses to me personally, i am not on the
linuxppc-dev list.

Thanks,

Peter

--
Peter Abrahamsen
p1rabbit@halcyon.com
http://www.halcyon.com/p1rabbit
PGP: 0xC279D219: C080 6D6F 4492 C63D 20B7 8D41 8B17 C781 C279 D219


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
