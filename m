Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401l712Lm2zDr71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 08:22:36 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2ELJEhC083931
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 17:22:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gq9kcm8w9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 17:22:33 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 17:22:32 -0400
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Josh Sklar <sklar@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
In-reply-to: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
Date: Wed, 14 Mar 2018 18:22:07 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fu52jqtc.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


SF Markus Elfring <elfring@users.sourceforge.net> writes:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Mar 2018 09:03:42 +0100
>
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

I liked it. Thanks!

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
