From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: official patches ceasing at 2.4.18 on kernel.org?
Date: Thu, 3 Jul 2003 12:51:00 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGOECEDIAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20030703164408.GJ954@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks very much Tom!

Chuck

> -----Original Message-----
> From: owner-linuxppc-dev@lists.linuxppc.org
> [mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Tom Rini
> Sent: Thursday, July 03, 2003 12:44 PM
> To: Chuck Meade
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: official patches ceasing at 2.4.18 on kernel.org?
>
>
>
> On Wed, Jul 02, 2003 at 10:26:45PM -0400, Chuck Meade wrote:
>
> > I am creating a local ppc 2.4.21 tree.  I see the following are
> > the most recent 2.4.21 tags on the BK server:
> >
> >   v2.4.21_linuxppc_2_4_devel
>
> The linuxppc_2_4_devel tree, as of 2.4.21.
>
> >   v2.4.21_linuxppc
>
> The linuxppc_2_4 tree, as of 2.4.21
>
> >   v2.4.21
>
> kernel.org, as of 2.4.21.
>
> > What would be great is for the patches under ports on kernel.org
> > to be carried forward/kept up to date.  If that is not going to
> > be continued, then what is the best way to create the same thing,
> > i.e. a solid 2.4.21 ppc tree, using what is available via BK?
>
> bk export -tpatch -rv2.4.21 -rv2.4.21_linuxppc_2_4_devel
> Should give you a patch against 2.4.21, to get the 2_4_devel tree, for
> example.
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
