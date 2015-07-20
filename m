Return-Path: <prvs=636808b93=david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36CFB1A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 23:52:35 +1000 (AEST)
Message-ID: <55ACFA96.9060102@citrix.com>
Date: Mon, 20 Jul 2015 14:41:42 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Peter Zijlstra
 <peterz@infradead.org>
CC: <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm-ppc@vger.kernel.org>, Alexander Graf
 <agraf@suse.de>, Paul Mackerras <paulus@samba.org>, David Vrabel
 <david.vrabel@citrix.com>, <xen-devel@lists.xenproject.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Xen-devel] [PATCH v2 1/3] drivers/xen/preempt: use need_resched()
 instead of should_resched()
References: <20150715095201.12246.49283.stgit@buzz>
In-Reply-To: <20150715095201.12246.49283.stgit@buzz>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/07/15 10:52, Konstantin Khlebnikov wrote:
> This code is used only when CONFIG_PREEMPT=n and only in non-atomic context:
> xen_in_preemptible_hcall is set only in privcmd_ioctl_hypercall().
> Thus preempt_count is zero and should_resched() is equal to need_resched().

Applied to for-linus-4.3, thanks.

David
