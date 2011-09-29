Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06CFD1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 09:52:30 +1000 (EST)
Subject: Re: [PATCH] powerpc: book3e: WSP: Add Chroma as an new WSP/PowerEN
	platform.
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317333352-17628-1-git-send-email-jimix@pobox.com>
Date: Thu, 29 Sep 2011 18:52:41 -0500
Message-Id: <520D1933-900E-4A3C-BFDE-28FD2352A9FD@kernel.crashing.org>
References: <1317333352-17628-1-git-send-email-jimix@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 29, 2011, at 4:55 PM, Jimi Xenidis wrote:

> arch/powerpc/configs/chroma_defconfig | 1817 =
+++++++++++++++++++++++++++++++++

Seems kind big, you probably need a 'make savedefconfig' ;)

- k=
