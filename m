Return-Path: <jacmet@sunsite.dk>
Received: from smtp40.mobistarmail.be (unknown [193.252.23.61])
	by ozlabs.org (Postfix) with ESMTP id CA9C3DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 09:09:48 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf4016.mobistarmail.be (SMTP Server) with ESMTP id 1CF8C7000967
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 01:09:42 +0200 (CEST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Using Cypress EZ-Host on ML403/5
References: <4623A197.6000104@computing.dundee.ac.uk>
	<528646bc0704190717o14da4b58r5ef69a8e77ade198@mail.gmail.com>
	<87vefsmoaj.fsf@sleipner.barco.com>
	<528646bc0704190750r4b6d76y72a862c249fa0520@mail.gmail.com>
	<9305ca410704240042w7f8b12fau331a6407f45be74c@mail.gmail.com>
	<528646bc0704240637sd3797a2q5ae48db19155ba61@mail.gmail.com>
	<9305ca410704270141y66928deyab59300b8c5ccb95@mail.gmail.com>
	<528646bc0704301223q2024505ah5308147ba6eead0a@mail.gmail.com>
	<528646bc0705021408o1e1f25d7pa81905081d06ed8e@mail.gmail.com>
	<87wszqucpr.fsf@p4.be.48ers.dk>
	<fa686aa40706041559i43c03574kfc6ca7574e16ab3b@mail.gmail.com>
Date: Tue, 05 Jun 2007 01:12:01 +0200
In-Reply-To: <fa686aa40706041559i43c03574kfc6ca7574e16ab3b@mail.gmail.com>
	(Grant Likely's message of "Mon, 4 Jun 2007 16:59:57 -0600")
Message-ID: <87vee3s4am.fsf@p4.be.48ers.dk>
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

 >> Yeah, I've also had quite varied success with USB sticks - Some work
 >> just fine, others not at all. I'm still trying to figure out what goes
 >> wrong..

 Grant> I think I've solved this problem.  The driver wasn't checking the
 Grant> active flag on TDs in check_td_list().  If the c67x00 ran out of time
 Grant> in a frame, not all the TDs would get processed.  Without this check
 Grant> the HCD would interpret unprocessed TDs as successfully completed.

Ahh - Good catch!

 Grant> I've also got a fair number of comments/changes on the driver in patch
 Grant> form.  I'll send it to the list shortly.

Great, I'm looking forward to seeing it!

-- 
Bye, Peter Korsgaard
