Return-Path: <7eggert@web.de>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB941B6F1A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 05:50:03 +1000 (EST)
From: Bodo Eggert <7eggert@web.de>
Subject: Re: [PATCH 0/7] De-couple sysfs memory directories from memory
	sections
To: Nathan Fontenot <nfont@austin.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Mon, 12 Jul 2010 21:30:56 +0200
References: <f5t7d-2ZJ-23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Message-Id: <20100712194958.1A32B2D6595@mail-in-10.arcor-online.net>
Reply-To: 7eggert@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@austin.ibm.com> wrote:

> The file 'split' allows for splitting the
> directory in two, with each new directory covering half as many
> memory sections as the previous directory.

Just some random thoughts:

1) Why is it needed/helpful?
2) If it is needed, why not take an int to split after n entries?
