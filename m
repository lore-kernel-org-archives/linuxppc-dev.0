Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 1F01267A2C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 05:39:57 +1100 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j12Idrs26872
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Feb 2005 13:39:54 -0500 (EST)
Message-ID: <42011E77.6040906@nortel.com>
Date: Wed, 02 Feb 2005 12:39:51 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: new binutils breaks "tlbie" instruction in kernel?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The "tlbie" instruction has a bit which may be set to indicate regular 
or large page size.  This used to be set via an optional second parameter.

Apparently some time between binutils versions 2.15.91.0.2 and 
2.15.92.0.2 a change went in to make this second parameter mandatory, 
which breaks the kernel ppc code.

What is the recommended way to fix this?  Do all binutils versions 
understand the second parameter, or will "sufficiently old" versions 
choke on it?


Thanks,

Chris
