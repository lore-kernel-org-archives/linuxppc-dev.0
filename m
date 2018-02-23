Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp17n55Z5zF1hN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 06:12:37 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1NJCUvn050732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:12:35 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gapyk4mw1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 14:12:31 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 23 Feb 2018 12:09:17 -0700
Subject: Re: [PATCH 00/38] cxlflash: OpenCXL transport support
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/html;
	charset=us-ascii
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <2d8f0a69-5fef-d027-1456-1a9088c2333b@au1.ibm.com>
Date: Fri, 23 Feb 2018 12:05:56 -0600
Cc: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <2d8f0a69-5fef-d027-1456-1a9088c2333b@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <49A29C0A-75E2-4604-835A-095D319DC006@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"ApplePlainTextBody"><div dir=3D"auto" style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"ApplePlainTextBody"><div dir=3D"auto" style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D"ApplePlainTextBody"><div =
class=3D"ApplePlainTextBody"><br><blockquote type=3D"cite">On Feb 22, =
2018, at 10:13 PM, Andrew Donnellan &lt;andrew.donnellan@au1.ibm.com&gt; =
wrote:<br><br>On 23/02/18 09:20, Uma Krishnan wrote:<br><blockquote =
type=3D"cite">This patch series adds OpenCXL support to the cxlflash =
driver. With<br>this support, new devices using the OpenCXL transport =
will be supported<br>by the cxlflash driver along with the existing CXL =
devices. An effort is<br>made to keep this transport specific function =
independent of the existing<br>core driver that communicates with the =
AFU.<br></blockquote><br>It's "OpenCAPI" for the standard, and "ocxl" =
for the driver - I'd rather not add "OpenCXL" to our already somewhat =
confusing proliferation of names :)<br><br></blockquote><br>I agree. I =
will fix it in V2. Thanks for the feedback.<br><br><blockquote =
type=3D"cite">I'll try to review as much of the ocxl-specific stuff as I =
can get to, though I'm a bit busy with the OpenCAPI skiboot work and =
reviewing the libocxl userspace library at the =
moment.<br><br><br>Andrew<br><br>-- <br>Andrew Donnellan =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;OzLabs, ADL Canberra<br>andrew.donnellan@au1.ibm.com &nbsp;IBM =
Australia Limited<br></blockquote><br></div></div></div></body></html>=
