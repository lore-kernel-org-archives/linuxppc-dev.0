Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 239E72BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2004 06:58:16 +1000 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i9IKwBZ00907
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2004 16:58:12 -0400 (EDT)
Message-ID: <41742E62.6060603@nortelnetworks.com>
Date: Mon, 18 Oct 2004 14:58:10 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: tbr/decrementer and SMP -- do the cpus stay in sync?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I thought I remembered some discussion on this a while back, but I can't find it 
in my archived messages or online, so here goes.

With SMP PowerPC machines (specifically the dual G5) we sync up the timebase 
when we bring up the second CPU.  Are we guaranteed that they stay in sync after 
that point, or will they drift?  If they drift, do we have any idea how much?

Thanks,

Chris
