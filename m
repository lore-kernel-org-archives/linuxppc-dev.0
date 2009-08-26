Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7C609B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 15:47:08 +1000 (EST)
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.211.194]) by ozlabs.org (Postfix) with ESMTP id BC4FEDDDB6
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 15:47:06 +1000 (EST)
Received: by ywh32 with SMTP id 32so4865968ywh.11
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 22:47:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1251253245-16616-1-git-send-email-galak@kernel.crashing.org>
References: <1251253245-16616-1-git-send-email-galak@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 25 Aug 2009 23:46:43 -0600
Message-ID: <fa686aa40908252246k5d76ee18rf3440d0225eba6d2@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Pull ppc32 PCI features into common
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 25, 2009 at 8:20 PM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
> Some of the PCI features we have in ppc32 we will need on ppc64
> platforms in the future. =A0These include support for:
>
> * ppc_md.pci_exclude_device
> * indirect config cycles
> * early config cycles
>
> We also simplified the logic in fake_pci_bus() to assume it will always
> get a valid pci_controller. =A0Since all current callers seem to pass it
> one.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Looks okay to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
