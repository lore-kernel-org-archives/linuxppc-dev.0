Return-Path: <srs0=vdcl=eu=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRn3s47jfzDrJB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 14:06:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zRn3s3Hvyz8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 14:06:01 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zRn3s03pnz9sQm
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2018 14:06:00 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0P2wcsC145917
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2018 22:05:58 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fq3knechs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2018 22:05:58 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 24 Jan 2018 20:05:57 -0700
Date: Wed, 24 Jan 2018 19:05:52 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] powerpc/ftw: Document FTW API/usage
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1516157443-17716-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <57a1be39-df84-d678-7560-e2543824472d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57a1be39-df84-d678-7560-e2543824472d@infradead.org>
Message-Id: <20180125030552.GB12170@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap [rdunlap@infradead.org] wrote:

> > +        struct ftw_setup_attr ftwattr;
> > +
> > +        fd = open("/dev/ftw", O_RDWR);
> > +
> > +        memset(&rxattr, 0, sizeof(rxattr));
> 
> Is that supposed to be ftwattr (2x above)?

Yes. I agree with your other comments as well and will send a new version.

Thanks for the detailed review.

Sukadev
