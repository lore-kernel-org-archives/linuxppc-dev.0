Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.tce.com (dmzraw4.extranet.tce.com
	[157.254.234.139]) by ozlabs.org (Postfix) with ESMTP id 86A5367B32
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 19:10:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 23 Jun 2005 11:10:01 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D93@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: RE: [OT?] recommendations for a small footprint DB for PPC system?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert P. J. Day wrote:
>  any recommendations for a small, relational database that can be
>cross-compiled with ELDK 3.1.1 for a PPC system?  it's not going to be
>holding a lot of records (about 1000, more or less), and will be
>initialized and loaded at system boot time, at which point the
>majority of operations will be read, with only occasional writes.

For a simple database, what about libdb ?
Otherwise there's http://freshmeat.net/projects/sqlite/

Regards,
--=20
Stephane
