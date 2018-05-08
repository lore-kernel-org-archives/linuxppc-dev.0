Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g10G0NYmzF1ls
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 10:42:05 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w480coLb113424
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 20:42:03 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htv034byb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 20:42:03 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 8 May 2018 01:42:01 +0100
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com, corbet@lwn.net
Date: Tue, 08 May 2018 10:41:55 +1000
In-Reply-To: <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-7-alastair@au1.ibm.com>
 <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525740115.7796.46.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > In order for a userspace AFU driver to call the Power9 specific
> > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> > make that call.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   Documentation/accelerators/ocxl.rst |  1 -
> >   drivers/misc/ocxl/file.c            | 25
> > +++++++++++++++++++++++++
> >   include/uapi/misc/ocxl.h            |  4 ++++
> >   3 files changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/accelerators/ocxl.rst
> > b/Documentation/accelerators/ocxl.rst
> > index ddcc58d01cfb..7904adcc07fd 100644
> > --- a/Documentation/accelerators/ocxl.rst
> > +++ b/Documentation/accelerators/ocxl.rst
> > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> >     Obtains configuration information from the card, such at the
> > size of
> >     MMIO areas, the AFU version, and the PASID for the current
> > context.
> > 
> > -
> 
> 
> Intended?
> 
> Other than that,
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 

Nope, I'll fix that, thanks.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
