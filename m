Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3wS94JZzzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 08:28:57 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DMOD4r119955
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:28:48 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sv16xc17-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:28:48 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 18:28:47 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2] cxl: Enable PCI device IDs for future IBM CXL adapters
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1490371400-33398-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 17:28:33 -0500
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
References: <1490371400-33398-1-git-send-email-mrochs@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-Id: <8639654F-B890-4CA4-ACF2-8A5DFDC3F75B@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 24, 2017, at 11:03 AM, Matthew R. Ochs =
<mrochs@linux.vnet.ibm.com> wrote:
>=20
> Add support for future IBM Coherent Accelerator (CXL) devices
> with an IDs of 0x0623 and 0x0628.
>=20
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Hi Michael,

I think this one might have been overlooked. We'd like to try and
get this in for 4.12 to match up with our 4-port series in cxlflash.

Let me know if you feel it needs anything else. Thanks!


-matt

> ---
> Changes in v2:
> - Add device ID 0x0628
>=20
> drivers/misc/cxl/pci.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 80a87ab..dd606a2 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -123,6 +123,8 @@ static const struct pci_device_id cxl_pci_tbl[] =3D =
{
> 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0623), },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0628), },
> 	{ PCI_DEVICE_CLASS(0x120000, ~0), },
>=20
> 	{ }
> --=20
> 2.1.0
>=20
