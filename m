Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8wtB4BKCzDqKh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 22:05:06 +1100 (AEDT)
Date: Fri, 27 Jan 2017 20:46:59 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Refactor program interrupt related
 code into separate function
Message-ID: <20170127094659.GB17935@fergus.ozlabs.ibm.com>
References: <1485347242-4692-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485347242-4692-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 01:27:22PM +0100, Thomas Huth wrote:
> The function kvmppc_handle_exit_pr() is quite huge and thus hard to read,
> and even contains a "spaghetti-code"-like goto between the different case
> labels of the big switch statement. This can be made much more readable
> by moving the code related to injecting program interrupts / instruction
> emulation into a separate function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
