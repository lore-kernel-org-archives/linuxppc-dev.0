Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 33D512BC0F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2004 02:36:05 +1000 (EST)
Message-ID: <415D8768.8080808@nortelnetworks.com>
Date: Fri, 01 Oct 2004 10:35:52 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: netdev@oss.sgi.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 
Subject: kernel crash with G5 Xserve and sungem driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have patched 2.6.9-rc2 to run in 32-bit mode on the G5 Xserve.

When I compile a kernel with the tigon driver and the sungem driver both 
built-in, the kernel crashes.  Removing the sungem driver fixes the problem.

Is there a known incompatibility between the sungem driver and the Xserve?

I don't have crash output at the moment, but I can probably get it eventually.

Chris
