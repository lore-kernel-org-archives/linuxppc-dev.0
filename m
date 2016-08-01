Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3GHM0nk5zDqWP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 09:48:14 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71NiRSx085588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 19:48:12 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gnv18h0v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 19:48:11 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 20:48:10 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 6BF3F1DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 19:47:58 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71Nm60l10224104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:48:06 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u71Nm6V3000322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:48:06 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] kexec_file_load implementation for PowerPC
Date: Mon, 01 Aug 2016 20:48:05 -0300
In-Reply-To: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1610701.WIqt6fioh4@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Am Donnerstag, 07 Juli 2016, 13:23:26 schrieb Thiago Jung Bauermann:
> Note: We are currently discussing whether we need a new syscall so that
> userspace can provide a custom device tree for the new kernel. Even if
> that ends up being the way forward, it would affect only patches 7 and 8,
> and even in those patches a significant part of the code would stay
> the same. Therefore, it's still important for me to get feedback on
> this series.

The discussion about how to pass device tree nodes/properties via 
kexec_file_load seems a bit stuck at the moment. Since I'm targeting kernel 
4.9 for this patch series, and considering that this code is functional and 
useful as it is, I'd like to keep the process of upstreaming it in motion.

Ping?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
