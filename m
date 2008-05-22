Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F0AFDE51C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 07:44:38 +1000 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.8])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4MLUEuE016704
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 May 2008 14:30:15 -0700
To: linuxppc-embedded@ozlabs.org
Subject: Question about "native" compiling
MIME-Version: 1.0
Message-ID: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 22 May 2008 14:30:07 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I apologize if the list finds this off topic, but I'm at a loss of who to 
ask the question and thought this would be a good place to start.  Our 
target is an MPC8347E PowerQUICC II Pro, and we're using the latest kernel 
(2.6.25).  We started this project by building on x86 and doing 
cross-compiling to the powerpc target.  As the project progressed and we 
started adding applications we found that we couldn't cross-compile 
postgress among other things.  So we switched to native compilation on the 
target.  Problem is, it's extreamly slow.  Now our idea is to get our 
hands on a PowerPC based Mac, load it up with Ubuntu and do native builds 
on that.  The question is, which Mac to get?  The concern is this: a G5 is 
64-bit but the 8347E is 32-bit.  If we do our compiles on a G5 is it 
really a 'native' compile or is it a cross-compile and we're back in the 
same boat as we were with the x86?  Should we use a G4 instead?

Thanks for any advice or pointers to other places where I can find 
information.

Bruce
