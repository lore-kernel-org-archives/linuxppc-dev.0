Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id B3FF82BD6A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 08:42:20 +1000 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id i8HMLOw22157
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 18:21:24 -0400 (EDT)
Message-ID: <414B6363.5060106@nortelnetworks.com>
Date: Fri, 17 Sep 2004 16:21:23 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: support for revision C of the mcpn765?
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We've got revision C of the mcpn765 from Motorola.  The main difference appears 
to be that it uses the 82c686 chip rather than the 586, requiring some extra 
checking in mcpn765_init2().

Is there a patch already out there, or should I send one in?

Chris
