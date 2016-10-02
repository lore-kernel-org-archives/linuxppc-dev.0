Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sn2wT5TczzDrSD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Oct 2016 22:27:53 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u92BMScJ019227
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Oct 2016 07:27:50 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25txvnur35-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Oct 2016 07:27:50 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 2 Oct 2016 21:27:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BBF473578053
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Oct 2016 22:27:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u92BRkUJ42926118
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Oct 2016 22:27:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u92BRkJF031459
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Oct 2016 22:27:46 +1100
Date: Sun, 2 Oct 2016 22:28:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Quieten EEH message when no adapters are
 found
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1475366978-18713-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475366978-18713-1-git-send-email-anton@ozlabs.org>
Message-Id: <20161002112808.GA10715@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 02, 2016 at 11:09:38AM +1100, Anton Blanchard wrote:
>From: Anton Blanchard <anton@samba.org>
>
>No real need for this to be pr_warn(), reduce it to pr_info().
>
>Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
