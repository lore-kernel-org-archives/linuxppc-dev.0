Message-Id: <200007300505.BAA23374@mal-ach.watson.ibm.com>
To: bob@kunk.jriver.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS/6000 Model 170 Boots Linux 
In-Reply-To: Message from bob@kunk.jriver.com
   of "Sat, 29 Jul 2000 15:32:15 CDT." <20000729203215.23597.qmail@kunk.jriver.com>
Date: Sun, 30 Jul 2000 01:05:15 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> bob  writes:

bob> The Power 3 in the 170 is running in 32 bit mode I assume?

	Yes, the system is running a 32-bit kernel.

bob> Also with reference to the PPC linux system running on the Beta Power 4
bob> is this also in 32 bit mode?

	Yes, the test system was running a 32-bit kernel.

bob> The Power 3,  RS6000-III and Power 4 are all 64 bit chips from what I
bob> understand and IBM's literature makes me think that AIX is indeed running
bob> in 64 bit mode with the ability to run 32 bit apps.

	The AIX 4.3 kernel is running in 32-bit mode on 64-bit processors
supporting 32-bit and 64-bit user applications.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
