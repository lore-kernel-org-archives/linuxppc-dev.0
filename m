Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 2511D2BC0F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2004 05:43:03 +1000 (EST)
Message-ID: <415DB334.4010809@nortelnetworks.com>
Date: Fri, 01 Oct 2004 13:42:44 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
References: <415D8768.8080808@nortelnetworks.com>
	<20041001193153.GN27499@sunbeam.de.gnumonks.org>
In-Reply-To: <20041001193153.GN27499@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@oss.sgi.com, linuxppc-dev@ozlabs.org
Subject: Re: kernel crash with G5 Xserve and sungem driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Harald Welte wrote:

> Just don't compile (or load) the sungem driver on those boxes.

Hmm.  That's a pain.  We've got G5 desktops too, and it would be nice to be able 
to run one kernel for both.  It'd be better (IMHO) to fix the driver so it 
doesn't crash.

Chris
