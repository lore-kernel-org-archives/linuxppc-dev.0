Date: Sat, 16 Mar 2002 13:09:04 -0500 (EST)
From: Daniel Berlin <dan@dberlin.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: modem in new TiPB and iBooks ?
In-Reply-To: <20020316181811.C31449@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.44.0203161307130.11658-100000@dberlin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 16 Mar 2002, Harald Welte wrote:

> On Thu, Mar 14, 2002 at 10:41:41PM -0500, Daniel Berlin wrote:
> >
> > On Thu, 2002-03-14 at 21:06, Bastien Nocera wrote:
> > >
> > > Hi,
> > >
> > > If I don't have my head too far up my arse yet, I think this might
> > > interest quite a few people (ie. not me).
> > >
> > > http://lwn.net/2002/0314/a/hcf.php3
> > >
> > > Am I on the right track ?
> >
> > Yes, except both BenH and I have already emailed him, no response from
> > him at all yet.
>
> Update: Marc Boucher has now replied to BenH's mail after I bugged him ;)
>
> There are several issues:
>
> 1) His current driver doesn't support the USB version of the winmodems yet.
>    However, connexant is interested in providing drivers for the USB versions
>    aswell.
I'm aware of this, i've already got the ACM USB driver able to detect/let
me access the modem, I just don't have the engine necessary to drive it.

>
> 2) The proprietary libraries used in the driver need to be compiled for the
>    PPC architecture.  To do this, Marc needs access to a PPC machine for
>    compiling the proprietary source.
I know this as well, and offered to do this.
In fact, all I asked for was the binary modules compiled for PPC, given
that I give him access to a PPC machine.
The rest I can do myself.

--Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
