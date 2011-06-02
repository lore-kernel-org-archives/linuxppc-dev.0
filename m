Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35964B6FA7
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jun 2011 05:11:27 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO
	not set
Date: Thu, 2 Jun 2011 19:11:18 +0000
Message-ID: <BANLkTikyOf5xYHy1pCbcg06BkyST4QNyXA@mail.gmail.com>
References: <1307031956-11686-1-git-send-email-galak@kernel.crashing.org>
	<BANLkTinQxjxefrCC0HDVGChzAKXoTBch7g@mail.gmail.com>
In-Reply-To: <BANLkTinQxjxefrCC0HDVGChzAKXoTBch7g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 2, 2011 at 12:32 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> Should be Reported-by Timur, right?

Technically, yes.  For the record, I don't care about these things.
It implies that only willing to report the problem, but too lazy to
fix it; which is true, but I'd hate to see that fact permanently
etched in the git history. :-)

--=20
Timur Tabi
Linux kernel developer at Freescale=
