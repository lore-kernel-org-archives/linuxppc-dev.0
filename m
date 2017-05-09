Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMY2F6cmSzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:49:09 +1000 (AEST)
Subject: P.A. Semi: "PR" KVM configure error after KVM changes for 4.12
To: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <ac5f236e-c503-320f-b240-1d4c1d8916b3@xenosoft.de>
 <a914cbc1-6b5a-be45-bb33-8133dc5c5ba0@xenosoft.de>
 <1f53280e-7525-bd48-56e0-21744b16d76d@xenosoft.de>
 <eecee02c-04d5-0a06-2949-bfb11aa72bbd@xenosoft.de>
 <151de9a6-4167-2ea5-01ef-cdb639b96961@xenosoft.de>
 <2CA07D5E-BC02-4852-ADD0-10D8128A48AD@xenosoft.de>
 <6D82E7E7-AC2A-465F-9CA0-14C5D572B493@xenosoft.de>
 <3b9e052f-2247-0d62-9594-ed1efdac9d63@xenosoft.de>
 <8fb787e3-edd0-e7ae-fb8b-5b785422226b@xenosoft.de>
 <d38b72b2-b2b7-97a9-41a5-72651faa0937@xenosoft.de>
 <32d4e529-c0ef-3a97-05c0-6b9933d18e92@xenosoft.de>
 <c992819c-ee60-c3e6-bc12-761f3aee3998@xenosoft.de>
 <1f331c00-1833-340b-2725-81c85f4a2a28@xenosoft.de>
 <03ce35a5-6996-6d9e-0a39-3cc21f7cd291@xenosoft.de>
 <3ffbd423-be9f-dc37-4e81-9097bf8a34fb@xenosoft.de>
 <68fca557-87c8-5c60-208d-5b57da1152c5@xenosoft.de>
 <1c52e1a2-580a-474c-a09d-21c879f97419@xenosoft.de>
 <9c66da5e-1a89-8948-d100-3996f194aca3@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <69e6beec-e909-4ca8-64e4-d8f45627af97@xenosoft.de>
Date: Tue, 9 May 2017 10:42:51 +0200
MIME-Version: 1.0
In-Reply-To: <9c66da5e-1a89-8948-d100-3996f194aca3@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

After the first batch of KVM changes for 4.12 merge window I get the 
following error message if I want to configure the Linux kernel with KVM 
PR support on my P.A. Semi board.

warning: (KVM_BOOK3S_64) selects SPAPR_TCE_IOMMU which has unmet direct 
dependencies (IOMMU_SUPPORT && (PPC_POWERNV || PPC_PSERIES))

Did you change the system requirements for KVM? Does it only work on IBM 
pSeries machines now?

Before the changes, I successfully compiled the Git version of kernel 
4.12 with KVM PR support. I successfully tested it with Mac-on-Linux/KVM PR.

Cheers,

Christian
