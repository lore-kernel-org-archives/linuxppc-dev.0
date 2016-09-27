Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk87G1xTqzDrWH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 04:12:09 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RI8wEi132236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 14:12:06 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qr691y4y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 14:12:06 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 14:12:06 -0400
Date: Tue, 27 Sep 2016 11:11:16 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 06/19] perf, tools: Support alias descriptions
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160927174100.GO5588@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160927174100.GO5588@kernel.org>
Message-Id: <20160927181116.GA18012@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> Em Thu, Sep 15, 2016 at 03:24:43PM -0700, Sukadev Bhattiprolu escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Add support to print alias descriptions in perf list, which
> > are taken from the generated event files.
> > 
> > The sorting code is changed to put the events with descriptions
> > at the end. The descriptions are printed as possibly multiple word
> > wrapped lines.
> 
> So, now I'm trying to reproduce the results below, but I couldn't find a
> tarball with those .json files for me to use, can you provide me with
> one?

The data files are in my github, in the json-code+data-v21 branch
starting with 23bb101. They are individual commits rather than a
tarball though.

	>       https://github.com/sukadev/linux.git
	>
	>       Branch                  Description
	>       ------------------------------------------------------
	>       json-code-v21           Source Code only
	>       json-code+data-v21      Both code and data(for build/test/pull)
	> 

Sukadev
