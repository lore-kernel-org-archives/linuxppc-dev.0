Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2C9CBDE985
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 01:05:14 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with more
	than 2GB of RAM
Date: Wed, 9 Jul 2008 17:05:04 +0200
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<300E659E-810B-4C90-A8C8-78E39B73D8B0@kernel.crashing.org>
In-Reply-To: <300E659E-810B-4C90-A8C8-78E39B73D8B0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807091705.04315.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 July 2008, Kumar Gala wrote:
> On Jul 9, 2008, at 8:44 AM, Stefan Roese wrote:
> > This patch enables 32bit PPC's (with 36bit physical address space,
> > e.g.
> > IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
> > replacing types (unsigned long -> phys_addr_t).
>
> should the commit header really be >= 4G.  I don't think there is any
> issue with 2-4G support as it stands.

Right. I'll fix this up and resubmit.

Thanks.

Best regards,
Stefan
