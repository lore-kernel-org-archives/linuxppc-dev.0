Return-Path: <support@skycomputers.com>
Received: from omr5.networksolutionsemail.com (omr5.networksolutionsemail.com
	[205.178.146.55]) by ozlabs.org (Postfix) with ESMTP id 407D9B7D39
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 23:38:45 +1100 (EST)
Received: from localhcloudmarkgw1 (mail.networksolutionsemail.com
	[205.178.146.50])
	by omr5.networksolutionsemail.com (8.13.6/8.13.6) with ESMTP id
	o14CchqU020122
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Feb 2010 07:38:43 -0500
From: "Sky Support" <support@skycomputers.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
References: <201002022240.o12Me1iY018842@imap1.linux-foundation.org>
	<1265239287.8287.125.camel@pasglop>
	<B134A7A4FBBE4369B89D3A549EA6BD88@your4dacd0ea75>
	<1265242715.8287.127.camel@pasglop>
	<7AAE08D947A546FB84E5992F288C0A32@your4dacd0ea75>
	<1265248884.8287.129.camel@pasglop>
Subject: RE: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on
	unsigned
Date: Thu, 4 Feb 2010 07:38:43 -0500
Message-ID: <B3F8FF6AD2C741E7A084DC402EF4BEED@sky.internal>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1265248884.8287.129.camel@pasglop>
Cc: waite@skycomputers.com, roel.kluin@gmail.com, gorcunov@gmail.com,
	linuxppc-dev@ozlabs.org, galak@gate.crashing.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't plan on carrying it forward, so I assume that ripping it out will
not affect us.
Anything new would be completely new development.



-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
Sent: Wednesday, February 03, 2010 9:01 PM
To: support
Cc: akpm@linux-foundation.org; linuxppc-dev@ozlabs.org;
roel.kluin@gmail.com; galak@gate.crashing.org; gorcunov@gmail.com;
waite@skycomputers.com
Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on
unsigned

On Wed, 2010-02-03 at 20:47 -0500, support wrote:
> I doubt we'll be going to be using 7448's any more for future product
lines.

Hi !

Well, that isn't really the question :-) Is there any interest in
ensuring that your current Sky is supported by upstream linux kernels or
not ? As I said, the current kernel seems to contain code relative to
the Sky CPU that is never enabled and potentially has issue. Are you
guys interested in fixing this so that upstream linux supports your
existing products, or should we just rip the code out ?

Cheers,
Ben.
 
> Dave Bushee
> Director OEM Sales and Services
> SKY Computers Inc.
> 27 Industrial Ave.
> 978-250-2420 x232
> www.skycomputers.com
> 
> 
> ----- Original Message ----- 
> From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
> To: "support" <support@skycomputers.com>
> Cc: <akpm@linux-foundation.org>; <linuxppc-dev@ozlabs.org>; 
> <roel.kluin@gmail.com>; <galak@gate.crashing.org>; <gorcunov@gmail.com>; 
> <waite@skycomputers.com>
> Sent: Wednesday, February 03, 2010 7:18 PM
> Subject: Re: [patch 1/2] powerpc: Sky CPU: redundant or incorrect tests on

> unsigned
> 
> 
> > On Wed, 2010-02-03 at 19:10 -0500, support wrote:
> >> The sky cpu is a PPC7448.
> >> I'm actually amazed that you guys are still working on a problem for
> >> a
> >> product that was finished a number of years ago, at the request of
> >> someone
> >> who hasn't worked here for years.
> >> I sorry you, seem to have been wasting your time.
> >> I think, but am NOT sure,  that our HAA function sets it off.
> >> http://www.skycomputers.com/Systems/HAA_HMM.php
> >>
> >> Still, we have finished the product some time ago, and as far as
> >> reported
> >> have no problems.
> >> Again, I'm sorry you have wasted any time on this, we just recently
> >> found
> >> these emails.
> >
> > Well, there seem to be some code in the Linux kernel related to that CPU
> > that is either dead or incomplete. So if you guys have no interest in
> > it, we might just rip it out completely.
> >
> > Cheers,
> > Ben.
> >
> >
> > 
