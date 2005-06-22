Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 50ED567B5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 08:36:45 +1000 (EST)
Received: from [10.1.1.113] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 22 Jun 2005 18:11:23 -0400
Date: Wed, 22 Jun 2005 18:11:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0506221810260.12659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [OT?] recommendations for a small footprint DB for PPC system?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  any recommendations for a small, relational database that can be
cross-compiled with ELDK 3.1.1 for a PPC system?  it's not going to be
holding a lot of records (about 1000, more or less), and will be
initialized and loaded at system boot time, at which point the
majority of operations will be read, with only occasional writes.

  thoughts?

rday
