Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F546DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 10:07:42 +1100 (EST)
Date: Thu, 28 Feb 2008 18:07:28 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: 2.6.25-rc3 Sequoia build - section mismatch(es)
In-Reply-To: <20080224073800.4bdb30ac@zod.rchland.ibm.com>
References: <1203848259l.2313l.1l@antares.localdomain>
	<20080224073800.4bdb30ac@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080228230743.6F546DDDFF@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Upon building the default Sequoia (AMCC-440EPx) configuration, the 
MODPOST step warns about section mismatches:
    WARNING: modpost: Found 5 section mismatch(es).
    To see full details build your kernel with:
    'make CONFIG_DEBUG_SECTION_MISMATCH=y'

After using the 
