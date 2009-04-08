Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 8B146DDFD5
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 10:36:26 +1000 (EST)
Received: by qyk8 with SMTP id 8so6332463qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Apr 2009 17:36:24 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49DBE858.9040004@kernel.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
Date: Tue, 7 Apr 2009 19:36:23 -0500
Message-ID: <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Timur Tabi <timur@freescale.com>
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:

> Hmmm... that means intx isn't set by default. =A0I'm not sure what is
> the right thing to do here. =A0I think it's something which should be
> handled by the PCI layer. =A0Oh well, maybe we should just revert the
> change and keep setting intx?

cc'ing linuxppc-dev

I really don't know what should be done.  It seems to make sense to
have the PCI layer enable interrupts.

This seems to be a powerpc-specific bug, but I don't know enough of
the PCI subsystem.

--=20
Timur Tabi
Linux kernel developer at Freescale
