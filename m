Message-ID: <036301c2fead$7d3aad70$3000a8c0@primag>
From: "Mark Powell" <medp@primagraphics.co.uk>
To: "Binh Nguyen" <binh@us.ibm.com>,
	<linuxppc-embedded@lists.linuxppc.org>,
	<linuxppc-users@lists.linuxppc.org>
References: <OFA4C6E054.A1AC76DA-ON87256D02.00711FB1@us.ibm.com> <20030408233356.GC13256@zax> <20030408172421.A22476@home.com>
Subject: Re: Ethernet Driver Needed for IBM PPC 405 (Codename Walnut)
Date: Wed, 9 Apr 2003 16:34:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday, April 09, 2003 at 1:24 AM, Matt Porter wrote:
>
> On Wed, Apr 09, 2003 at 09:33:56AM +1000, David Gibson wrote:
> >
> > On Tue, Apr 08, 2003 at 04:45:47PM -0400, Binh Nguyen wrote:
> > >
> > > I heard that some one has written an ethernet driver for the IBM PPC
405
> > > board for Linux some time ago.  The author  has seen  performance
> > > improvement because the driver services interrupts in a better way.
If
> > > some one has a copy of the driver, would you please send it to
> > > binh@us.ibm.com.  Also any tips on how to install the driver is
> > > appreciated.  Thanks very much.
> >
> > The driver is included in the linuxppc_2_4_devel and linuxppc-2.4
> > kernel trees.  You probably want to be using one of those trees in any
> > case.
>
> He might be referring to a post here (in the last 6 months or so)
> where the poster mentioned writing a replacement EMAC driver that
> had better performance than the standard driver.  I can't seem to
> locate the post at the moment, but perhaps somebody else remembers
> and can find it in the archives.
>

Was it this one:
"RE: Network performance loss when migrating to 2.4.18 on Walnut 4 05GP"
http://lists.linuxppc.org/linuxppc-embedded/200303/msg00079.html

I tried the patch mentioned (against MontaVista 2.1) and found a few %
improvement, not as much as I was hoping.

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
