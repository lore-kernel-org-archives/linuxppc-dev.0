Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 6E12F67A07
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2005 00:49:15 +1000 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j57EnCJ24346
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2005 10:49:12 -0400 (EDT)
Message-ID: <42A5B3E6.9030401@nortel.com>
Date: Tue, 07 Jun 2005 08:49:10 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: syntax for clobber list with inline assembly
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'm writing some inline assembly for ppc.  To specify that r3 is used, I 
know I need to list it in the clobbered list.

When doing this, do I specify it as "3" or "r3", or are both valid?

Thanks,

Chris
