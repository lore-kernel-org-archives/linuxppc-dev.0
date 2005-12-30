Return-Path: <grant.likely@secretlab.ca>
Received: from localhost.localdomain (S0106001346b91f0f.cg.shawcable.net
	[68.147.210.21]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D231568982
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 21:51:10 +1100 (EST)
In-Reply-To: 
Date: Fri, 30 Dec 2005 03:29:58 -0700
Message-Id: <11359385973413-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/8] Migration to platform bus for Virtex devices
Reply-To: Grant Likely <grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is a set of patches to:
- Migrate ML300 to the platform bus
- Decouple xparameters.h from the rest of the kernel in preparation of
  flattened device tree.  Ultimate goal is to remove xparameters from
  kernel entirely and have the boot loader pass the details in.
- Add support for ML403 reference design
- Add defconfigs for both ML300 and ML403

I've only tested these on an ML403.  Would somebody be able to test
these on an ML300?  Comments?

Cheers,
g.
