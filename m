Return-Path: <jacmet@sunsite.dk>
Received: from smtp40.mobistarmail.be (smtp40.mobistarmail.be [193.252.23.61])
	by ozlabs.org (Postfix) with ESMTP id DBE48DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 07:59:30 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Using Cypress EZ-Host on ML403/5
References: <4623A197.6000104@computing.dundee.ac.uk>
	<528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
	<87zm54mt3j.fsf@sleipner.barco.com>
	<528646bc0704190717o14da4b58r5ef69a8e77ade198@mail.gmail.com>
	<87vefsmoaj.fsf@sleipner.barco.com>
	<528646bc0704190750r4b6d76y72a862c249fa0520@mail.gmail.com>
	<9305ca410704240042w7f8b12fau331a6407f45be74c@mail.gmail.com>
	<528646bc0704240637sd3797a2q5ae48db19155ba61@mail.gmail.com>
	<9305ca410704270141y66928deyab59300b8c5ccb95@mail.gmail.com>
	<528646bc0704301223q2024505ah5308147ba6eead0a@mail.gmail.com>
	<528646bc0705021408o1e1f25d7pa81905081d06ed8e@mail.gmail.com>
Date: Wed, 02 May 2007 23:39:44 +0200
In-Reply-To: <528646bc0705021408o1e1f25d7pa81905081d06ed8e@mail.gmail.com>
	(Grant Likely's message of "Wed, 2 May 2007 15:08:33 -0600")
Message-ID: <87wszqucpr.fsf@p4.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 >> > Did you have a chance to try it out yet?

 Grant> Hey Peter,

 Grant> I've got it running on my board now after figuring out how to wire up
 Grant> external interrupts in EDK.  :-)

 Grant> Good success with keyboards and mice.  Events come through no problem.

Great!

 Grant> Some block devices seem to be giving me grief.  I have no problem with
 Grant> my SanDisk ImageMate CF reader.  However, I've got a SanDisk Curzer
 Grant> Micro that gets reset during transfers.  Is this something you've seen
 Grant> before?  Log output is below.

Yeah, I've also had quite varied success with USB sticks - Some work
just fine, others not at all. I'm still trying to figure out what goes
wrong..

 Grant> I've also got a QuickCam Messinger that I'm going to test isochronos
 Grant> transfers with as well.

Ok. I've had a webcam and USB audio devices working OK. Isochronos
transfers are the most tricky ones to implement though, so don't
expect wonders (E.G. I get audio stutter if I do a lot of bulk
tranfers at the same time).

Thanks for the feedback!

-- 
Bye, Peter Korsgaard
