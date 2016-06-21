Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYpSF5zhwzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 23:27:41 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LDO9ni005676
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 09:27:39 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23pe03k2at-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 09:27:39 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 07:27:38 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [v6,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <87eg7qg79t.fsf@vajain21.in.ibm.com>
Date: Tue, 21 Jun 2016 08:27:34 -0500
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mikey <mikey@neuling.org>, manoj <manoj@linux.vnet.ibm.com>
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
 <87k2hkgs6v.fsf@vajain21.in.ibm.com>
 <1466483778-sup-4320@x230.ozlabs.ibm.com>
 <87eg7qg79t.fsf@vajain21.in.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Message-Id: <2686A514-2808-4F08-8514-5E08B5D3608A@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 21, 2016, at 5:34 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> =
wrote:
>=20
> Hi Ian,
>=20
> Ian Munsie <imunsie@au1.ibm.com> writes:
>=20
>> Excerpts from Vaibhav Jain's message of 2016-06-20 14:20:16 +0530:
>>=20
>> What exactly is the use case for this API? I'd vote to drop it if we =
can
>> do without it.
> Agree with this. Functionality of this API can be merged with
> cxl_set_driver_ops when called with NULL arg for cxl_afu_driver_ops.

Passing a NULL arg instead of calling an 'unset' API is fine with us.

I'll add that for cxlflash, I can't envision a scenario where we'll =
unset the
driver ops for a context.
