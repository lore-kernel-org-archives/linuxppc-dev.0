Date: Tue, 23 Mar 2004 10:31:22 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM 440GX, Ocotea...
Message-ID: <20040323183122.GA6724@gate.ebshome.net>
References: <4057CCD40003780D@mssbzhh-int.msg.bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4057CCD40003780D@mssbzhh-int.msg.bluewin.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 23, 2004 at 12:02:31PM +0100, Wolfgang Grandegger wrote:
>
> we are currently trying to understand which PPC Linux
> kernel tree is best suited for the IBM 440GX on the
> Ocotea eval board. We would like to support the 405GP
> and 440GP as well.

linuxppc-2.4

>
> The Ocotea 440GX board seems to be supported in the
> "linuxppc_2_4_devel" tree. Is this board configuration
> up-to-date and still maintained?

unlikely. linuxpp_2_4_devel is officialy "dead" tree :).

> A more up-to-date implementation seems to be in the
> "linuxppc-2.4" tree. Are there some open issues or known
> problems?

New UIC mode isn't supported yet.
Work on GigE support is still not finished yet.

> I realized that the L2 cache has been disabled
> recently:
>
>   $ cat arch/ppc/platforms/ocotea.c
>   ...
>   /* Disable L2-Cache due to hardware issues */
>   ibm440gx_l2c_disable();
>
> Does this mean that the L2 cache is unusable on current
> revisions of the chip? [That's why we would like to use
> this chip.]

Yes, we found problems with current chip revisions (A & B).
Ask your IBM contact for more information.

> Does this tree support the 405GP and 440GP as well?

Yes.

> Could
> anybody make some comments on the stability? We currently
> use the "linuxppc_2_4_devel" tree for these processors
> with little problems.

I'm using linuxppc-2.4 as of 2.4.21 in production for 440GP,
440GX, 405GPr, 405EP based hardware.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
