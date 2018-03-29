Return-Path: <prvs=06264cd0af=ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BtjV6h6kzF1k3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 05:35:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2TIZFpN024528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 14:35:37 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h11634a3n-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 14:35:36 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 14:35:35 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v3 00/41] cxlflash: OCXL transport support and
 miscellaneous fixes
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <yq1o9j7j34o.fsf@oracle.com>
Date: Thu, 29 Mar 2018 13:35:30 -0500
Cc: James Bottomley <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <yq1o9j7j34o.fsf@oracle.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-Id: <CDF15A59-080C-4904-8F28-F79AFD32AF0C@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On Mar 28, 2018, at 4:34 PM, Martin K. Petersen =
<martin.petersen@oracle.com> wrote:
>=20
>=20
> Uma,
>=20
>> This patch series adds OCXL support to the cxlflash driver. With this
>> support, new devices using the OCXL transport will be supported by =
the
>> cxlflash driver along with the existing CXL devices. An effort is =
made
>> to keep this transport specific function independent of the existing
>> core driver that communicates with the AFU.
>>=20
>> The first three patches contain a minor fix and staging improvements.
>>=20
>> This series is intended for 4.17 and is bisectable.
>=20
> Something this big really needs to be submitted around rc2/rc3. It's =
way
> too late in the cycle to ensure proper zeroday coverage for all these
> commits.
>=20
> I have started a 4.18/scsi-queue branch to hold this series for now.
> The 4.18 branch will be rebased once 4.17rc1 is out in a few weeks. =
Your
> changes won't show up in for-next until then either.

I did send the first version of this series just after 4.16rc2 but the =
reviews took a while and the V3 is cutting close unless we do have an =
rc8 for 4.16 :)

I understand what you are saying and agree with you. Thanks for keeping =
me posted.=
