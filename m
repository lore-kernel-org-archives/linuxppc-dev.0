Return-Path: <dhlii@comcast.net>
Received: from alnrmhc14.comcast.net (alnrmhc14.comcast.net [206.18.177.54])
	by ozlabs.org (Postfix) with ESMTP id 4C126DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 15:39:45 +1100 (EST)
Message-ID: <45F4D72F.8010101@comcast.net>
Date: Sun, 11 Mar 2007 23:29:35 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: compiling withoug glibc
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


    I have several projects that need to be built using GCC but
absolutely no external libraries, headers etc.
    not glibc, not uClibc, nothing.

    I also need to do this under both windows and Linux.

    I have been somewhat successful by renaming directories inside the
crosscompiler subdirectory so that gcc, ... can't find any standard
libraries etc.

    But I can not get this to work uniformly accross platforms, and I
can not trivially reverse it when I do need glibc.

    I have the vaguest clue that doing this has something to do with
triggering gcc to run through different peices of the "specs" file,
    but what I can find of documentation is opaque too me.

    A clue would be greatly appreciated.





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
