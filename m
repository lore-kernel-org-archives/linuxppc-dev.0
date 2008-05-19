Return-Path: <boutcher@cs.umn.edu>
Received: from mail.cs.umn.edu (mail.cs.umn.edu [128.101.34.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.cs.umn.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 673C6DDF49
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 02:22:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18481.41759.969242.972595@gargle.gargle.HOWL>
Date: Mon, 19 May 2008 10:56:15 -0500
To: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/1] ibmvscsi: Non SCSI error status fixup
In-Reply-To: <12112108763801-patch-mail.ibm.com>
References: <12112108763801-patch-mail.ibm.com>
From: boutcher@cs.umn.edu (Dave Boutcher)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 May 2008 10:27:56 -0500, Brian King <brking@linux.vnet.ibm.com> said:
> 
> Some versions of the Virtual I/O Server on Power
> return 0x99 in the non-SCSI error status field as success,
> rather than 0. This fixes the ibmvscsi driver to treat this
> response as success.

Yeah....0x99...that's an intuitive value for success.

Dave B
