Return-Path: <Bernhard.Weirich@riedel.net>
Received: from mail.riedel.net (mail.riedel.net [213.70.193.150])
	by ozlabs.org (Postfix) with ESMTP id 64E2FB7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Dec 2009 19:50:46 +1100 (EST)
From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 23 Dec 2009 09:50:39 +0100
Subject: msi / msix on PPC405EX?
Message-ID: <6680AE1BD102B9419251E785D19F5D030178135A@ExchN1.riedel.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am wondering whether msi / msix should work on PPC405EX. A call to pci_en=
able_msi returns: -38 / ENOSYS, function not implemented.
Can someone tell me if I am missing out something or if msi is indeed not i=
mplemented on this platform?

Thanks,=20
Bernhard=
