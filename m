Date: Fri, 7 Jul 2000 12:19:55 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <qpg0pmgtko.fsf@erbium.epact.se>
Message-ID: <Pine.HPX.4.10.10007071209230.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 7 Jul 2000, Michael Lundkvist wrote:

> If I can find a stable version it is an option. And I actually have
> plenty of time to look. I need a rock-stable system by the end of this
> year.

Ok, I hoppe 2.4 will be out then...

> I'll try 2.2.17pre10 tonight and see if I have more luck with that.

Well, I'm going to put my patches for 2.2.16 in an untested directory
then...

> I guess I should talk to Ramix. They have been helpful before.
> I'll also try to go back to an older version of the
> CMD646-driver. There are a few timing related setup changes in the
> newer versions.

This might indeed be the problem. My 2400 are not heavily stressed but
nevertheless they are stable: one has 52 days and the other 39 days
uptime. The second one had a strange behaviour when a lightning struck the
telescope however and had to be powered down before rebooting, hard reset
through front panel push button would not work (not even reaching PPCBUG
boot messages).

> > The only accessible place (with adequate lab equipment) are the buffers:
> > cut the input or the output of the receive buffer and connect it to the
> > power supply (safer on the input since it can directly be connected to
> > the buffer power supply while I'm not sure that some versions of the
> > Universe are not 3.3V only)   .
> >
>
> OK. Then it looks quite possible. Thanks for the info.

Thee only problem is to locate this damned buffer (just find which one is
connected to the VME bus SYSRST but there are so many).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
