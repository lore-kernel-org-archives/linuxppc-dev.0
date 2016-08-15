Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCRxL0bxhzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 17:31:01 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id vy10so3190106pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 00:31:01 -0700 (PDT)
Date: Mon, 15 Aug 2016 17:30:49 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Message-ID: <20160815073049.GB21080@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470956898-5991-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> Adapt all callers to the new function prototype.
>

Could you please expand on this?
 
> In addition, change the type of kexec_buf.buffer from char * to void *.
> There is no particular reason for it to be a char *, and the change
> allows us to get rid of 3 existing casts to char * in the code.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> ---

Looks good otherwise

Acked-by: Balbir Singh <bsingharora@gmail.com>
