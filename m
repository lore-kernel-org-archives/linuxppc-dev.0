Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWqfs5mvrzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 16:15:49 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1R5FCw1082066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 00:15:47 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28u640q4vp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 00:15:47 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 00:15:46 -0500
Date: Mon, 27 Feb 2017 10:45:35 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powernv:idle: Fix bug due to labeling ambiguity in
 power_enter_stop
Reply-To: ego@linux.vnet.ibm.com
References: <1488144787-26010-1-git-send-email-ego@linux.vnet.ibm.com>
 <20170227103707.77f9ca18@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170227103707.77f9ca18@kryten>
Message-Id: <20170227051535.GA1463@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,
On Mon, Feb 27, 2017 at 10:37:07AM +1100, Anton Blanchard wrote:
> Hi Gautham,
> 
> > +handle_esl_ec_set:
> 
> Unless we want to expose this to things like perf, we might want to
> make it a local label (eg .Lxx)

Sure. We don't want to expose this to perf at least as of now! Will
resend the patch with a local label.
> 
> Anton
>

--
Thanks and Regards
gautham.
