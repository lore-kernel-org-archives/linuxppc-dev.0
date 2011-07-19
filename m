Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10CCDB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 02:55:57 +1000 (EST)
Date: Tue, 19 Jul 2011 11:55:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 04/14] 83xx/mpc834x_itx: drop pq2pro-localbus-specific code
Message-ID: <20110719115545.52efca3d@schlenkerla.am.freescale.net>
In-Reply-To: <1311065631-3429-5-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-5-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Jul 2011 12:53:41 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> As localbus on mpc8349e-mitx now provides simple-bus compatibility, we
> can drop code asking for pq2pro-localbus devices on mpc834x_itx boards.

Do we have a good reason for breaking compatibility with older device trees?

-Scott
