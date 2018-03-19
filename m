Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404p5Q3dHgzF1V4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 07:46:47 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] PCI set flag PCI_SCAN_ALL_PCIE_DEVS for P.A. Semi
 boards
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 19 Mar 2018 21:46:34 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Olof Johansson <olof@lixom.net>
Message-Id: <65A318E5-6022-4673-9C75-5C272EA83BAF@xenosoft.de>
References: <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <dc228918-652a-e24c-ce7b-8d1b30153d3b@xenosoft.de>
 <639e975f-1b3a-4f85-9a40-13fe2473fc28@xenosoft.de>
 <20180319191310.GG77194@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bjorn,

Thanks for your reply. Olof wrote this patch.

@Olof
Could you please sign off this patch?

Thanks,
Christian

On 19. Mar 2018, at 20:13, Bjorn Helgaas <helgaas@kernel.org> wrote:

The patch looks fine, but I need a signed-off-by line before I can apply
it.  See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst

---

arch/powerpc/platforms/pasemi/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pasemi/pci.c
b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..ea54ed2 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -224,6 +224,8 @@ void __init pas_pci_init(void)
         return;
     }

+    pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
     for (np =3D NULL; (np =3D of_get_next_child(root, np)) !=3D NULL;)
         if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
             of_node_get(np);

--
