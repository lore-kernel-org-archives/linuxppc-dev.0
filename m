Return-Path: <bhelgaas@google.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8E80B7074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 04:23:18 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so4243307bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 11:23:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339766154-7470-1-git-send-email-liwp.linux@gmail.com>
References: <1339766154-7470-1-git-send-email-liwp.linux@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 12:22:53 -0600
Message-ID: <CAErSpo7REiSBsWP0JNwUGi1m0HdK3H0=e0t2k-3L_Z+b4sMkMw@mail.gmail.com>
Subject: Re: [PATCH 3/7][TRIVIAL][resend] drivers/pci: cleanup kernel-doc
 warning
To: Wanpeng Li <liwp.linux@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christoph Lameter <cl@linux-foundation.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>, David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Gavin Shan <shangw@linux.vnet.ibm.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
 Jason Wessel <jason.wessel@windriver.com>, Al Viro <viro@zeniv.linux.org.uk>,
 cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Michal Hocko <mhocko@suse.cz>, trivial@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Minchan Kim <minchan@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 15, 2012 at 7:15 AM, Wanpeng Li <liwp.linux@gmail.com> wrote:
> From: Wanpeng Li <liwp@linux.vnet.ibm.com>
>
> Warning(drivers/pci/setup-bus.c:277): No description found for parameter =
'fail_head'
> Warning(drivers/pci/setup-bus.c:277): Excess function parameter 'failed_l=
ist' description in 'assign_requested_resources_sorted'
>
> Signed-off-by: Wanpeng Li <liwp.linux@gmail.com>
> ---
> =A0drivers/pci/setup-bus.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 8fa2d4b..9165d25 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -265,7 +265,7 @@ out:
> =A0* assign_requested_resources_sorted() - satisfy resource requests
> =A0*
> =A0* @head : head of the list tracking requests for resources
> - * @failed_list : head of the list tracking requests that could
> + * @fail_head : head of the list tracking requests that could
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 not be allocated
> =A0*
> =A0* Satisfy resource requests of each element in the list. Add

I applied this; it should appear in my "next" branch tomorrow.
