Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 7EDB22BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 03:36:02 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 8 Oct 2004 13:36:02 -0400
Date: Fri, 8 Oct 2004 13:29:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410081322160.24667@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: next set of proposed microcode patch changes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   slowly, but surely.  so, assuming that that last submitted patch 
gets applied, here's the next set of changes i'm thinking about. 
weigh in one way or the other.  some are aesthetic, some are more 
significant.  (if you have objections to that last patch, just make 
the suggestion here and i can take care of it in the next round.)

   1) change all variable references containing "I2C" to "IIC" since
 	the latter appears to have historical precedent

   2) break out individual patches from within cpm_load_patch()
 	into separate functions in micropatch.c.  that function
 	is just getting too darned long and it's only going to get
 	longer

   3) remove all of the arrays from micropatch.c and, following the
 	model in wolfgang's 2.4 kernel tree, put them in separate
 	.h files that are simply included based on the config
 	variable.

 	more ambitiously, put all these individual patch files in
 	a "patches" directory in arch/ppc/8xx_io/ to avoid cluttering
 	this directory

   4) at least *start* adding some help content to the Kconfig file

thoughts?  and now, off to lunch.

rday
