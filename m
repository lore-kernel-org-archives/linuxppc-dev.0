Message-ID: <3AC783FC.29377AAF@iiic.ethz.ch>
Date: Sun, 01 Apr 2001 21:39:40 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Bill Fink <billfink@capu.net>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: xine, ppc and illegal instructions
References: <Pine.LNX.4.21.0104011246570.868-100000@gwiz.nasa.atd.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bill Fink wrote:

> I updated to the latest Paulus rsync kernel (2.4.3-pre8) and the
> latest gcc (2.95.3-2v) and 2.1 glibc (glibc-2.1.3-15g) from Franz,
> but unfortunately none of this helps.  xine 0.4.01 still gets
> illegal instructions (sometimes it gets a segmentation fault
> instead).

Have you tried other kernels? A lot of people including me have experienced
sporadic signals, most often with ldconfig, with Paulus' tree. I'm running
BenH's tree now and haven't seen it yet.

This is not to call Paulus' tree lame or anything. :) It's just that he
apparently has rather experimental stuff in it, which can always lead to
instabilities.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
