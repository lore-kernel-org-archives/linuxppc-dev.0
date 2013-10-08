Return-Path: <himanshu.madhani@qlogic.com>
Received: from mx0b-0016ce01.pphosted.com (mx0b-0016ce01.pphosted.com
 [67.231.156.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5CBF62C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:01:11 +1100 (EST)
From: Himanshu Madhani <himanshu.madhani@qlogic.com>
To: Alexander Gordeev <agordeev@redhat.com>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts
 enablement code
Date: Tue, 8 Oct 2013 22:46:51 +0000
Message-ID: <ADFE82A996F10145934E45547759F7638C923C26@avmb3.qlogic.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
In-Reply-To: <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "VMware,
 Inc." <pv-drivers@vmware.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Andy King <acking@vmware.com>, linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
 Dept-Eng Linux Driver <Linux-Driver@qlogic.com>, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jon Mason <jon.mason@intel.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev <netdev@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alexander Gordeev [mailto:agordeev@redhat.com]
> Sent: Wednesday, October 02, 2013 3:49 AM
> To: linux-kernel
> Cc: Alexander Gordeev; Bjorn Helgaas; Ralf Baechle; Michael Ellerman;
> Benjamin Herrenschmidt; Martin Schwidefsky; Ingo Molnar; Tejun Heo; Dan
> Williams; Andy King; Jon Mason; Matt Porter; linux-pci; linux-mips@linux-
> mips.org; linuxppc-dev@lists.ozlabs.org; linux390@de.ibm.com; linux-
> s390@vger.kernel.org; x86@kernel.org; linux-ide@vger.kernel.org;
> iss_storagedev@hp.com; linux-nvme@lists.infradead.org; linux-
> rdma@vger.kernel.org; netdev; e1000-devel@lists.sourceforge.net; Dept-
> Eng Linux Driver; Solarflare linux maintainers; VMware, Inc.; linux-scsi
> Subject: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts enablement
> code
>=20
> As result of recent re-design of the MSI/MSI-X interrupts enabling patter=
n
> this driver has to be updated to use the new technique to obtain a optima=
l
> number of MSI/MSI-X interrupts required.
>=20
 "We will test this change for the driver and provide feedback."

> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Thanks,
Himanshu
