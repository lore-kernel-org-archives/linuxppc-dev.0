Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 53F07DDF33
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 02:21:50 +1100 (EST)
Message-ID: <60135.70.162.219.205.1236439301.squirrel@oz.embeddedx86.com>
In-Reply-To: <fa686aa40903062141n210f81d7g9f11154f3c78cadc@mail.gmail.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
	<fa686aa40903062141n210f81d7g9f11154f3c78cadc@mail.gmail.com>
Date: Sat, 7 Mar 2009 08:21:41 -0700 (MST)
Subject: Re: [PATCH, RFC]
From: "Eddie Dawydiuk" <eddie@embeddedarm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Eddie Dawydiuk <eddie@embeddedarm.com>
Reply-To: eddie@embeddedarm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

> On a more general note; this patch also diverges from the original
> model for simple image.  The idea behind simpleimage was that it would
> contain a fully formed device tree, with no fixups necessary.  I want
> to think carefully before diverging from that.

I wasn't aware of these design goals... I believe one can also modify the
default dts file such that the RAM size is not dynamically detected so the
fixups aren't required(although keep in mind I haven't tested this).
Although it is quite convenient to add the fixed-head.o so one can jump
into the simpleImage at offset 0 rather than having to check what the
offset should be each time a change is made.

//Eddie
