Message-ID: <3CE95FCB.ADF38CE0@ixiacom.com>
Date: Mon, 20 May 2002 13:42:51 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: When did ppc405 support stabilize?
References: <3CE94AE9.E18D2B1E@ixiacom.com> <20020520133149.A17318@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> Dan Kegel wrote:
> > I'd like to try older linuxppc_2_4_devel kernels
> > until I find where the problem started.
> > I guess I'll have to work my way backwards, since I don't know
> > when ppc405 support stabilized in that tree. ...
> >
> > BTW, here's the cheesy script I'm using to fetch old kernel versions;
> > I'm relying on the v2.4.xx tags.
>
> look into 'bk export' instead of the script.

Hmm.  I tried
$ bk export -rv2.4.14 bk://ppc.bkserver.net/linuxppc_2_4_devel mylinux
but it failed with
  Cannot find package root.
Can some bk expert suggest the right command for grabbing a plaintext
version of the linuxppc_2_4_devel kernel corresponding roughly to
2.4.xx?

> I believe the tags are off the base Linux kernel and they have never
> worked for the 405gp.

Oh.  Do you have any suggestions for how to retrieve 'ok' older
versions of the tree?  I can grab as of a date, but I imagine
I'd have to be fairly picky about the date to get something good.

> The recent trees have been working for me but there have been a lot
> of changes to try to get a common OCP framework.

(OCP has to do with the built-in peripherals?)  BTW,
I don't even need to get ethernet working; the bug I'm
after occurs even with loopback.  All I need working
is the serial port and the core kernel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
