Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Daniel Jacobowitz" <drow@false.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: Improved copy_page() function, about 30% speed up for mpc860!
Date: Wed, 5 Mar 2003 18:50:16 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCENKFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <20030305171234.GC19303@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Wed, Mar 05, 2003 at 01:19:04AM +0100, Joakim Tjernlund wrote:
> > > > from http://lists.linuxppc.org/linuxppc-dev/200303/msg00022.html
> > >
> > > Well, the whole change is at:
> > > http://ppc.bkbits.net:8080/linuxppc_2_4_devel/cset@1.118.1.428?nav=index.html|ChangeSet@-1d
> > >
> > > So, that should give it more context and make it clearer, I hope..

FYI, I undid the above patch and then dcbz failed horribly. Linux
just locks up. Using my BDI2000 I tried to single step over the offending dcbz
and it never got past it.

 Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
