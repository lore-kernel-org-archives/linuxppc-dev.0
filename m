Return-Path: <kernel-stuff@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [63.240.77.81])
	by ozlabs.org (Postfix) with ESMTP id 8B74868869
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2005 04:09:52 +1100 (EST)
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Stelian Pop <stelian@popies.net>,
	Michael Hanselmann <linux-kernel@hansmi.ch>
Date: Fri, 02 Dec 2005 17:02:23 +0000
Message-Id: <120220051702.24733.43907E1E000B191F0000609D220702293300009A9B9CD3040A029D0A05@comcast.net>
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	debian-powerpc@lists.debian.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My original patch is still work in progress and was intended as a starting point if someone was already adept with the trackpad stuff and was willing to help. 
(Basically it was a call for help - nothing for end users ;)

Things that remained to be done -

Either
1) Support for all PowerBooks in one code base (> Feb 2005)
Or
1) Create different versions for each one or two of them

Depending upon whether or not widely varying algorithms are needed for each variety.

2) Major part - reliably working code for finger movement detection for all Oct 2005 PowerBooks (15" itself seems to come with trackpads having entirely different characteristics.) 

3) Possibly Dual Finger Detection for scrolling - this is optional but would be good to have.

I am working on it as time and urges permit and it will speed up only if Johannes doesn't get his PowerBook or the one he gets is 0x0216 !!

Parag
