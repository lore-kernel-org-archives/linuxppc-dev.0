Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5158A67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 11:09:31 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <4232162D.5000100@mvista.com>
References: <4232162D.5000100@mvista.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 18:09:26 -0600
Message-Id: <1110586166.28218.10.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: akpm <akpm@osdl.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12] PPC32: Update chestnut platform files
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-03-11 at 15:05 -0700, Mark A. Greer wrote:
> Update Chestnut platform files.
> 
> - Set up mtd partition from arch-specific platform file and remove 
> obsoleted mtd map.

Could you forward this portion of the patch to the MTD maintainer?  That
way it has less of a chance getting re-added to -mm when Andrew grabs
the latest MTD bitkeeper tree.

thx,
josh
