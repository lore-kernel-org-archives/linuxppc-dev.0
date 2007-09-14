Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1C82DDF3F
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:01:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ1Mlk005674
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:01:22 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ16nR163382
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ16Sw011675
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:06 -0600
Message-Id: <20070914185410.387074000@linux.vnet.ibm.com>>
Date: Fri, 14 Sep 2007 13:54:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 0/4] Small 4xx updates for 2.6.24
Mime-Version: 1.0
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Below is a small update series for 4xx that I intend to put in my 2.6.24 branch
soon and send to Paul.  It contains an already acked cuboot wrapper for Bamboo,
a fix for the newly updated physmap_of driver, and updates to the walnut and
sequoia flash nodes in the DTS files.

josh

-- 
