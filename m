Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 191E8DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 05:56:01 +1100 (EST)
Date: Thu, 17 Jan 2008 13:06:39 -0600
From: Olof Johansson <olof@lixom.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc8-mm1 powerpc build errors
Message-ID: <20080117190639.GA9499@lixom.net>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, raisch@de.ibm.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

My powerpc build-all-defconfigs script found the following:

mpc837x_mds_defconfig. Brokage looks like it came from libata's
for_each_sg() patch.

drivers/ata/sata_fsl.c: In function 'sata_fsl_fill_sg':
drivers/ata/sata_fsl.c:337: error: redeclaration of 'si' with no linkage
drivers/ata/sata_fsl.c:326: error: previous declaration of 'si' was here

powerpc_allyesconfig:

drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_add':
drivers/net/ehea/ehea_main.c:2812: error: 'struct device_driver' has no member named 'kobj'
drivers/net/ehea/ehea_main.c:2815: error: 'struct device_driver' has no member named 'kobj'
drivers/net/ehea/ehea_main.c:2818: error: 'struct device_driver' has no member named 'kobj'
drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_remove':
drivers/net/ehea/ehea_main.c:2830: error: 'struct device_driver' has no member named 'kobj'


-Olof
