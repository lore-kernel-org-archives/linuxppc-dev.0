Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 5C7AA2BDB8
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2004 01:51:11 +1000 (EST)
Message-ID: <416BFD66.2090303@nortelnetworks.com>
Date: Tue, 12 Oct 2004 09:51:02 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: jonathan@jonmasters.org
References: <416709B8.8080107@vision.caltech.edu>	
	<4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>	
	<416B67DE.3050909@nortelnetworks.com>	
	<AB928930-1C2D-11D9-925F-000A95A4DC02@kernel.crashing.org>
	<35fb2e59041012073325afbcfc@mail.gmail.com>
In-Reply-To: <35fb2e59041012073325afbcfc@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
Subject: Re: Update frequency of Time Base reg?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Masters wrote:

> so e.g. in /proc/device-tree/cpus/PowerPC,G4/timebase-frequency.

Interesting.  Learn something new....

Just took a look at the code, and there are apparently some machines on which 
this is flaky.  To use this in userspace you'd want to account for that, and 
probably you'd want a backup calibration as well.

Chris
