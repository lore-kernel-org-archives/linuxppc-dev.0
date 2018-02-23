Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp1jg0XpCzF1lM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 06:38:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NJY8nb040688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:38:28 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gapm4xjxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:38:28 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 23 Feb 2018 12:38:27 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 00/38] cxlflash: OpenCXL transport support
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <2d8f0a69-5fef-d027-1456-1a9088c2333b@au1.ibm.com>
Date: Fri, 23 Feb 2018 13:38:23 -0600
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <2d8f0a69-5fef-d027-1456-1a9088c2333b@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <F0F5C6BC-8519-43F3-AD70-4380C059D0A8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Feb 22, 2018, at 10:13 PM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> On 23/02/18 09:20, Uma Krishnan wrote:
>> This patch series adds OpenCXL support to the cxlflash driver. With
>> this support, new devices using the OpenCXL transport will be =
supported
>> by the cxlflash driver along with the existing CXL devices. An effort =
is
>> made to keep this transport specific function independent of the =
existing
>> core driver that communicates with the AFU.
>=20
> It's "OpenCAPI" for the standard, and "ocxl" for the driver - I'd =
rather not add "OpenCXL" to our already somewhat confusing proliferation =
of names :)

I agree. :) I will fix it in V2. Thanks for the feedback.=
