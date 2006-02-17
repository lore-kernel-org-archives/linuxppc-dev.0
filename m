Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id CDF81679EA
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2006 10:14:46 +1100 (EST)
Date: Sat, 18 Feb 2006 00:14:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.16-rc4: known regressions
Message-ID: <20060217231444.GM4422@stusta.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
Cc: len.brown@intel.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-acpi@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
	Meelis Roos <mroos@linux.ee>, gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.16-rc4 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you was declared guilty for a breakage or I'm considering you in any 
other way possibly involved with one or more of these issues.


Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
Submitter  : John Stultz <johnstul@us.ibm.com>
Status     : still present in -git two days ago


Subject    : S3 sleep hangs the second time - 600X
References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Status     : problematic commit identified,
             further discussion is in the bug

Subject    : psmouse starts losing sync in 2.6.16-rc2
References : http://lkml.org/lkml/2006/2/5/50
Submitter  : Meelis Roos <mroos@linux.ee>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
Status     : Dmitry: Working on various manifestations of this one.
                     At worst we will have to disable resync by default
                     before 2.6.16 final is out and continue in 2.6.17 cycle.



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
