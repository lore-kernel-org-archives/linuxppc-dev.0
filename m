Date: Wed, 26 May 2004 10:35:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: curious about BK checkin protocol
Message-ID: <20040526103520.A13563@home.com>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain> <20040525102352.A1329@home.com> <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>; from rpjday@mindspring.com on Wed, May 26, 2004 at 07:19:53AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 26, 2004 at 07:19:53AM -0400, Robert P. J. Day wrote:
>
>
> On Tue, 25 May 2004, Matt Porter wrote:
>
> > On Tue, May 25, 2004 at 09:12:10AM -0400, Robert P. J. Day wrote:
> > >   i thought it had been well-established by now that this had to go.
> > > what's the protocol for someone putting these changes into the tree?
> > > just curious.
> >
> > Post a patch.  If it's something that is incorrect in linux-2.5
> > as well, then the patch is expected to be against linux-2.5.
>
> post to this list?  sure, if that's the right place.  the only reason i'm
> obsessed about that little fix as opposed to all the others that are going

Yes, post to this list for embedded-specific patches (8xx). If
it's a clear fix, somebody will put it into linux-2.5 and it
will be pulled into linuxppc-2.5 on the next merge. Put [PATCH]
in the subject and mention what BK tree it's made against.

Let me say this again, but a bit clearer so that _everybody_
understands.  A patch is the standard unit of communication here.
If you don't post a patch that represents your ideas or proposed
fixes, your thoughts are likely to get lost in all the noise on
these lists.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
