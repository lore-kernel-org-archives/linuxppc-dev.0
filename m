Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 7E72767A75
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Feb 2005 09:37:50 +1100 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j1EMbje13539
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Feb 2005 17:37:46 -0500 (EST)
Message-ID: <42112838.6020809@nortel.com>
Date: Mon, 14 Feb 2005 16:37:44 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: kernprof patches for ppc?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi guys,

I'm trying to track down a long-running code path on a UP 2.4.22 system 
running on an mcpn765 card.  It's got various vendor patches and drivers 
applied, and *something* is taking up to a second in the kernel very 
intermittantly.

Has anyone ported kernprof to ppc for 2.4?

Chris
