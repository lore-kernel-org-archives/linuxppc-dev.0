Date: Sun, 1 Apr 2001 17:08:09 -0400 (EDT)
From: Bill Fink <billfink@capu.net>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: xine, ppc and illegal instructions
In-Reply-To: <3AC783FC.29377AAF@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.21.0104011704090.9900-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Sun, 1 Apr 2001, Michel [iso-8859-1] Dänzer wrote:
>
> Bill Fink wrote:
>
> > I updated to the latest Paulus rsync kernel (2.4.3-pre8) and the
> > latest gcc (2.95.3-2v) and 2.1 glibc (glibc-2.1.3-15g) from Franz,
> > but unfortunately none of this helps.  xine 0.4.01 still gets
> > illegal instructions (sometimes it gets a segmentation fault
> > instead).
>
> Have you tried other kernels? A lot of people including me have experienced
> sporadic signals, most often with ldconfig, with Paulus' tree. I'm running
> BenH's tree now and haven't seen it yet.
>
> This is not to call Paulus' tree lame or anything. :) It's just that he
> apparently has rather experimental stuff in it, which can always lead to
> instabilities.

Hey, Grrrrrrrrrrrrrreattt!!!!!

That did the trick.  I rsync'ed BenH's latest 2.4.3 final kernel,
and now xine 0.4.01 works fine.  Now I just have to get MOL working
again with the latest kernels (probably just requires a rebuild).

Many, many thanks for the suggestion!

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
