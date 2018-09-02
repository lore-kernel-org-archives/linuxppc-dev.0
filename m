Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423FlG72KWzF3BX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 00:26:18 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w82ENtVP042739
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Sep 2018 10:26:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m888a681a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Sep 2018 10:26:15 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Sun, 2 Sep 2018 15:26:14 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
In-Reply-To: <20180901195337.3080204b@roar.ozlabs.ibm.com>
References: <20180901081745.2165-1-vaibhav@linux.ibm.com>
 <20180901195337.3080204b@roar.ozlabs.ibm.com>
Date: Sun, 02 Sep 2018 19:56:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3ckm0w0.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for looking into this patch Nick,

Nicholas Piggin <npiggin@gmail.com> writes:

> This is nice but I wonder if the default should be IPL and fast
> should be the option.

Fast-reset should work most of the times so I think it should be
default. Its also the current default which I am bit relunctant to
change.

We usually need full IPL reset only when we need to update skiboot or
have malfunctioning device that isnt being reset properly during
fast-reset. So I am believe full IPL resets will be less frequent hence
should be explicitly requested.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
