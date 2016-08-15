Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCdgj1zXDzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 00:49:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FEn0xO000573
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 10:49:49 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24tgu26x37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 10:49:48 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 11:49:46 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 3D0313520068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 10:49:24 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7FEni0A4649148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 11:49:44 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7FEnhkp014078
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 11:49:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: bsingharora@gmail.com
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Date: Mon, 15 Aug 2016 11:49:42 -0300
In-Reply-To: <20160815073049.GB21080@balbir.ozlabs.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160815073049.GB21080@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1906561.y8blzB2uZ8@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> > Adapt all callers to the new function prototype.
> 
> Could you please expand on this?

Is the following better?

Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.

> Looks good otherwise
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Thank you for reviewing this series!

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
