Date: Tue, 15 Jan 2002 18:02:30 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <20020115162546.GB764@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201151756200.11139-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Jan 2002, Tom Rini wrote:

>
> On Tue, Jan 15, 2002 at 01:21:26PM +0100, Kenneth Johansson wrote:
> >
> > I have some date problem BK think that we are at feb23 and that dose not look
> > right when running revtool. Do anyone else see this or is it my clone?

It is somebody who build a change set in the future :-), or at least with
its machine clock set well into the future end November. I noticed it and
Larry McVoy answered that he could not do anything since BK requires
increasing timestamps. You'll find it in the archives of linuxppc-dev for
November 2001.

IOW, check that your clock is not borked before committing changesets...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
