Date: Sat, 16 Mar 2002 18:18:11 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Daniel Berlin <dan@dberlin.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: modem in new TiPB and iBooks ?
Message-ID: <20020316181811.C31449@sunbeam.de.gnumonks.org>
References: <1016157991.23191.156.camel@dozo> <1016163702.3290.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1016163702.3290.7.camel@localhost.localdomain>; from dan@dberlin.org on Thu, Mar 14, 2002 at 10:41:41PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 14, 2002 at 10:41:41PM -0500, Daniel Berlin wrote:
>
> On Thu, 2002-03-14 at 21:06, Bastien Nocera wrote:
> >
> > Hi,
> >
> > If I don't have my head too far up my arse yet, I think this might
> > interest quite a few people (ie. not me).
> >
> > http://lwn.net/2002/0314/a/hcf.php3
> >
> > Am I on the right track ?
>
> Yes, except both BenH and I have already emailed him, no response from
> him at all yet.

Update: Marc Boucher has now replied to BenH's mail after I bugged him ;)

There are several issues:

1) His current driver doesn't support the USB version of the winmodems yet.
   However, connexant is interested in providing drivers for the USB versions
   aswell.

2) The proprietary libraries used in the driver need to be compiled for the
   PPC architecture.  To do this, Marc needs access to a PPC machine for
   compiling the proprietary source.

Marc seems to be quite busy at the moment, but he'll catch on on this
subject after returning to his office at March 23rd.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
