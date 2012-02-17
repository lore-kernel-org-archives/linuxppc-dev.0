Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A6CB1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 09:32:46 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 21/30] KVM: PPC: make e500v2 and e500mc mutually exclusive
Date: Fri, 17 Feb 2012 22:32:37 +0000
Message-ID: <CAOZdJXXxC5vdWrpz-sU0O+5oXS211DLYywqkQLwq0JOtRZyBHQ@mail.gmail.com>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
 <1329497818-9729-22-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-22-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2012 at 10:56 AM, Alexander Graf <agraf@suse.de> wrote:

> =A0config KVM_E500MC
> =A0 =A0 =A0 =A0bool "KVM support for PowerPC E500MC/E5500 processors"
> - =A0 =A0 =A0 depends on EXPERIMENTAL && PPC_E500MC
> + =A0 =A0 =A0 depends on EXPERIMENTAL && PPC_E500MC && !KVM_E500V2

There was a patch floating around that made a similar change to the
platform support, so that you could either build an e500v2 kernel and
enable support only for e500v2 board, or you could build an e500mc
kernel and enable support only for e500mc boards.  Last I heard, the
patch wasn't quite working, but that was a while ago.

Is there a connection between this patch and that one?

--=20
Timur Tabi
Linux kernel developer at Freescale=
