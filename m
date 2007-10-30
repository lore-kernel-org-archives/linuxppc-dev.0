Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D3C5DE215
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 02:22:30 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: libfdt as its own repo and submodule of dtc?
Date: Tue, 30 Oct 2007 10:23:25 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Jerry Van Baren <gerald.vanbaren@ge.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

It seems like have libfdt as a unique git repo that is a submodule of  
the things that need it (dtc, u-boot, etc.) might make some sense and  
it easier for the projects that need to pull it in.

Is this something you can take a look at? (or have other ideas on).

- k
