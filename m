Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A192FDE106
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 08:36:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Question about "native" compiling
Date: Thu, 22 May 2008 17:25:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E8024@ismail.innsys.innovsys.com>
In-Reply-To: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
References: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <Bruce_Leonard@selinc.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> Hi all,
>=20
> I apologize if the list finds this off topic, but I'm at a
> loss of who to
> ask the question and thought this would be a good place to
> start.  Our
> target is an MPC8347E PowerQUICC II Pro, and we're using the
> latest kernel
> (2.6.25).  We started this project by building on x86 and doing
> cross-compiling to the powerpc target.  As the project
> progressed and we
> started adding applications we found that we couldn't cross-compile
> postgress among other things.  So we switched to native
> compilation on the
> target.  Problem is, it's extreamly slow.  Now our idea is to get our
> hands on a PowerPC based Mac, load it up with Ubuntu and do
> native builds
> on that.  The question is, which Mac to get?  The concern is
> this: a G5 is
> 64-bit but the 8347E is 32-bit.  If we do our compiles on a G5 is it
> really a 'native' compile or is it a cross-compile and we're
> back in the
> same boat as we were with the x86?  Should we use a G4 instead?
>=20
> Thanks for any advice or pointers to other places where I can find
> information.=20

We use a dual G5 to do the exact same thing.
We have a compiler buildt on our target board (Freescale 8280), and on
the G5 we make sure that this compiler is being used (by chrooting into
a copy of the filesystem used on the target).=20
Then we compile all our apps .=20
Only thing we have to do speciial, is to add
--build=3Dpowerpc-unknown-linux-gnu --host=3Dpowerpc-unknown-linux-gnu =
to
the ./configure cammand line.
