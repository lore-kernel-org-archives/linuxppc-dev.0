Subject: Re: Status of linuxppc_2.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mlan@cpu.lu
Cc: panto@intracom.gr, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <E18WOU9-00009Z-00@piglet.grunz.lu>
References: <E18WOU9-00009Z-00@piglet.grunz.lu>
Content-Type: text/plain
Message-Id: <1042062383.637.1.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 08 Jan 2003 22:46:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-01-08 at 23:15, Michel Lanners wrote:
> On   8 Jan, this message from Pantelis Antoniou echoed through cyberspace:
> > I'm trying to compile linuxppc_2.5
> > and the following patch is needed to
> > make it compile.
>
> Tried to compile my standard kernel compile a while back, and found the
> following things broken (didn't have time to try fixing yet...):
>
> - 53c94 Mac SCSI
> - Matroxfb
>
> I also didn't try very hard to compile in face of these problems; there
> may be others still.
>
> Sorry I can't provide more info, but maybe this discussion makes ore
> people interested in 2.5 status, where I think a number of PPC-related
> things need to be seriously looked at, hopefully before it is declared
> 2.6...

Yup, mostly drivers though. Part of this is me lacking time or beeing
too lazy (pick your preferred one) as I want to rework most of the pmac
drivers to better fit in the new model. Some of it is in progress
locally though, hopefully I'll push something a couple of weeks from
now.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
