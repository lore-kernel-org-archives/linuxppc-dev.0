Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGlbg6pWvzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 06:28:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9HJRd1W060449
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 15:28:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dnkbrny8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 15:28:28 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 17 Oct 2017 20:28:26 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9HJSN2F25952442
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:28:24 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9HJSNIY010623
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 06:28:24 +1100
Subject: Re: char/tpm: Improve a size determination in nine functions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alexander Steffen
 <Alexander.Steffen@infineon.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 15:28:13 -0400
In-Reply-To: <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508268493.4513.39.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-17 at 20:41 +0200, SF Markus Elfring wrote:

> Do you find my wording “This issue was detected by using the
> Coccinelle software.” insufficient?

The question is not whether it is insufficient, but whether it is
appropriate.  Detecting Coccinelle issues is one step.  The next step
is deciding what to do with them.  Up to now, these messages have been
sent out as informational, not as patches.

Before sending patches to change existing code, address the "problem"
so that it doesn't continue to happen.  Only afterwards is it
appropriate to discuss what to do with existing code.

Mimi
