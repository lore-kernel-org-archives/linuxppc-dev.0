Return-Path: <Jeff.Fellin@rflelect.com>
Received: from noteshub.teal.com
	(ip67-155-213-211.z213-155-67.customer.algx.net [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 2699967A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 07:35:43 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
From: Jeff.Fellin@rflelect.com
Date: Fri, 22 Apr 2005 17:19:17 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Flash Statistics
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am looking for information in the kernel or elsewhere about flash usage
statistics. I'm interested in knowing how
many times a sector has been erased and written to. This doesn't have to be
for all time, since other tools
can erase and write the flash (U-boot), but just what the activity during
application processing. We use the
flash to store configuration files that are changeable and would like to
determine the expected lifetime
of the chips at use sites.

Any pointers to places where flash statistics are maintained or tools to
collect these statistics is
appreciated.

Thank you for your help in advance.


Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327
Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327
