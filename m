Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 80C812BF17
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jan 2005 02:25:22 +1100 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j07FPDD17778
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Jan 2005 10:25:14 -0500 (EST)
Message-ID: <41DEA9D8.3000506@nortelnetworks.com>
Date: Fri, 07 Jan 2005 09:25:12 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: G5 noisier under linux than firmware or OSX
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've noticed that when booting, right around the time the kernel first 
accesses my disks the fan speed jumps a bit.  It's not full-on vacuum 
cleaner howling, just a bit noisier.

I've only got the one machine so I can't do A/B comparisons, but it 
seems to be quieter when running OSX.

Is linux using the same fan speed parameters, or are we maybe a bit 
conservative?

Chris
