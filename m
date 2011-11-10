Return-Path: <amwang@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9C672B6F8F
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 21:09:37 +1100 (EST)
Message-ID: <4EBBA2B4.6070005@redhat.com>
Date: Thu, 10 Nov 2011 18:08:52 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 05/10] fadump: Convert firmware-assisted cpu state
 dump	data into elf notes.
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
 <20111107095553.1997.68645.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095553.1997.68645.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2011年11月07日 17:55, Mahesh J Salgaonkar 写道:
> +#ifdef CONFIG_FA_DUMP
> +	crash_fadump(regs, str);
> +#endif
> +

Please make it a nop for !CONFIG_FA_DUMP.
