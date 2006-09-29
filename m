Return-Path: <jean-baptiste.maneyrol@teamlog.com>
Received: from me-ml2.teamlog.fr (smtp-grenoble1.teamlog.com [194.2.68.40])
	by ozlabs.org (Postfix) with ESMTP id B1FD8679F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 18:15:59 +1000 (EST)
Received: from teamlog.com
	by grenoble.teamlog.com (x.x.x/x.x.x) with ESMTP        
	id k8T7jvr3028205
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Sep 2006 09:46:00 +0200
Subject: [PATCH] IBM GPIO driver for PowerPC 4xx is back from the dead
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@teamlog.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 29 Sep 2006 09:46:04 +0200
Message-Id: <1159515965.5613.4.camel@jb-portable>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is a patch for linux 2.6.18 that makes come back the old ibm gpio
driver from 2.6.10.

It is mainly useful for compatibility with old linux 2.4 from Montavista
I think, because direct memory access seems the new way to go.

Signed-off-by: Jean-Baptiste Maneyrol
<jean-baptiste.maneyrol@teamlog.com>


Jean-Baptiste Maneyrol
Teamlog - France
