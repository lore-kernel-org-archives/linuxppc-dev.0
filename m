Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A95C67A3B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 14:46:45 +1100 (EST)
Subject: iommu_table & it_busno
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 14:45:28 +1100
Message-Id: <1162439128.8514.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof !

Do we ever use that it_busno field in there ? Can I remove it ?

Cheers,
Ben.
