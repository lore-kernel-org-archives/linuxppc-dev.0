Message-Id: <5.1.0.14.2.20020823083119.02237e00@falcon.si.com>
Date: Fri, 23 Aug 2002 08:56:40 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: cygwin and embedded linux
In-Reply-To: <3.0.3.32.20020822173918.006dbb00@hollabaugh.com>
References: <Pine.LNX.4.40.0208220914420.2118-100000@mag.devdep.sysgo.d e>
 <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:39 PM 8/22/2002 -0600, Dr. Craig Hollabaugh wrote:

>At 09:36 AM 8/22/2002 +0200, Marius Groeger wrote:
> >2. The "emulation" will never be 100%. Maybe 99%. Maybe 99.99%. That last
> >   fraction can be a major PITA, because it is not obvious. To compile a
> >   kernel you need a lot of tools with a lot of explicit and implicit twists
> >   to them. It is just a gut feeling that I wouldn't want to rely on this,
> >   if I don't have to. The native way just seems the better way to do it to
> >   me.
>
>Just because your running on Linux doesn't mean anything because your
>duplicating
>the environment for cross-compiling anyway. So what does it matter if
>cygwin runs
>the cross tools or if Linux runs them?
>
>
>
>I'm curious ...
>
>How many out there actually are compiling PPC code natively on a PowerPC
>Linux box for their embedded devices?
>
>If so, do you run the same development versions on your desktop?
>
>How do you handle the FPU issues?
>
>Craig

We've done native on an iMac and cross on X86 linux.

Additional problems with Cygwin, from my point of view, is that you will
always be trailing the mainstream development because the Cygwin tools are
based on the native linux toolsets rebuilt (perhaps with customizations) to
allow them to run under DOS.  In addition, there are only a fraction as
many engineers using Cygwin vs. linux so your pool of "informed developers"
to ask questions of is much smaller.  Perhaps both of those objections go
away if you pay for Cygwin support :-).

My limited experience with Cygwin is that it is like cutting with a dull
knife: it can get the job done, but you have to work harder and the results
are a little more ragged than they should be.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
