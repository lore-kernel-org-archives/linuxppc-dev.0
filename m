Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9084067A6F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 01:11:49 +1000 (EST)
In-Reply-To: <D9D3C577-D46A-47BA-A1E0-844B95061F57@kernel.crashing.org>
References: <E1Frjet-0004PA-J1@jdl.com>
	<D9D3C577-D46A-47BA-A1E0-844B95061F57@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6C66805F-22DD-4EC2-B852-101BF1E84612@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: 8641 open nits
Date: Fri, 23 Jun 2006 10:11:39 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

Any update on the following nits:
* duplication of entry in cputable
* include of <platforms/86xx/mpc8641_hpcn.h> in asm-powerpc/mpc86xx.h
* mpc86xx_exclude_device cleanup and movement to pci.c
* fixing up mpc86xx_hpcn_probe()

- kumar
