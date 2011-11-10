Return-Path: <amwang@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 56E52B6F90
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 21:11:45 +1100 (EST)
Message-ID: <4EBBA303.9000307@redhat.com>
Date: Thu, 10 Nov 2011 18:10:11 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v4 10/10] fadump: Introduce config option for firmware
 assisted dump feature
References: <20111107095215.1997.14866.stgit@mars.in.ibm.com>
 <20111107095630.1997.54984.stgit@mars.in.ibm.com>
In-Reply-To: <20111107095630.1997.54984.stgit@mars.in.ibm.com>
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

于 2011年11月07日 17:56, Mahesh J Salgaonkar 写道:
> From: Mahesh Salgaonkar<mahesh@linux.vnet.ibm.com>
>
> This patch introduces a new config option CONFIG_FA_DUMP for firmware
> assisted dump feature on Powerpc (ppc64) architecture.
>

I think this patch can be folded into the 02/10, as this config
is already used there.

Thanks.
