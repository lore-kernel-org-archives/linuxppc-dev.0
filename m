Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxP6N3YyxzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 23:36:28 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8JDYQTb064574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 09:36:25 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d3130m47m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 09:36:25 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 19 Sep 2017 09:36:24 -0400
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Date: Tue, 19 Sep 2017 19:06:18 +0530
In-Reply-To: <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1505828178.30180.4.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-15 at 07:52 -0500, Rob Herring wrote:
> On Fri, Sep 15, 2017 at 6:04 AM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
> > Hi,
> >
> > Mainline kernel panics during DLPAR CPU add/remove operation.
> >
> > Machine Type: Power8 PowerVM LPAR
> > kernel 4.13.0
> 
> Did 4.12 work or when was it last working? I'm not seeing anything
> recent in the DT code that looks suspicious.

The issue was not seen with 4.12.0

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
