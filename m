Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id D52652BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 09:54:39 +1100 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j03MsTT01654
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Jan 2005 17:54:29 -0500 (EST)
Message-ID: <41D9CD19.50207@nortelnetworks.com>
Date: Mon, 03 Jan 2005 16:54:17 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: dcbz not used on ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I ran into some issues with the use of the dcbz instruction in the 
kernel for ppc32.  I'm now looking at porting our work to ppc64, and 
when I looked around a bit, I found that the dcbz instruction doesn't 
appear to be used in ppc64.

This leads me to ask:

1) Is it in fact true that ppc64 does not use dcbz in the kernel?
2) If so, why not?  Presumably it would be a win in some cases, 
otherwise they wouldn't be using it in ppc32.  Is there some other 
factore in play for ppc64?

Thanks,

Chris
