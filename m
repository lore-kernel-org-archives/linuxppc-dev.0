Date: Thu, 21 Nov 2002 23:47:34 -0500
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Segher Boessenkool <segher@koffie.nl>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	"Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Unexpected sleep on old iBook
Message-ID: <20021122044733.GA22490@paco.resnet.purdue.edu>
References: <2C5637A6A7CE844EA3C0A94565479F5275A2E2@dest-as20-002.int.bauer-partner.com> <Pine.LNX.4.33.0211191743560.11419-100000@opal.biophys.uni-duesseldorf.de> <20021119203347.GK8575@paco.resnet.purdue.edu> <3DDC7AFC.6A8B4A0C@koffie.nl>
Mime-Version: 1.0
In-Reply-To: <3DDC7AFC.6A8B4A0C@koffie.nl>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Segher Boessenkool spake unto us the following wisdom:
> Ethan Blanton wrote:
> > (Does it irritate anyone else that there seems to be no *good* way to
> >  differentiate iBook versions?  I'm sure there's some motherboard
> >  resource version that's unambiguous, but come on...)
>
> Just read the device tree:
>
> /proc/device-tree/model  gives you the model name.
> /proc/device-tree/scb#  gives you the revision number.

I actually meant for the layman ...  I realize that I can look up
system resources (in this case OF values) that will tell me, but hand
me an iBook and ask me what rev it is ... no clue.

Ethan

--
And if I claim to be a wise man / it surely means that I don't know.
                -- Kansas, "Carry on Wayward Son"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
