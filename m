Return-Path: <srs0=h+48=76=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgfY26JR1zDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:53:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xgfY25F5zz8t8c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:53:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xgfY16ywLz9s9Y
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 14:53:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4nKHN024072
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:53:24 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmbmx9x3e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2017 00:53:23 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 27 Aug 2017 22:53:22 -0600
Date: Sun, 27 Aug 2017 21:53:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/12] powerpc/vas: Define vas_win_id()
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-9-git-send-email-sukadev@linux.vnet.ibm.com>
 <87378gugx3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87378gugx3.fsf@concordia.ellerman.id.au>
Message-Id: <20170828045317.GE12907@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > Define an interface to return a system-wide unique id for a given VAS
> > window.
> >
> > The vas_win_id() will be used in a follow-on patch to generate an unique
> > handle for a user space receive window. Applications can use this handle
> > to pair send and receive windows for fast thread-wakeup.
> >
> > The hardware refers to this system-wide unique id as a Partition Send
> > Window ID which is expected to be used during fault handling. Hence the
> > "pswid" in the function names.
> 
> Same comment as previous patch.

Ok will drop them for now.

> 
> cheers
