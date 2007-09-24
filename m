Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57AA1DDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 18:23:35 +1000 (EST)
Date: Mon, 24 Sep 2007 01:22:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] fix mace_handle_misc_intrs compilation
Message-Id: <20070924012246.6ae8858f.akpm@linux-foundation.org>
In-Reply-To: <20070924081501.GA1797@aepfle.de>
References: <20070924081501.GA1797@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Sep 2007 10:15:01 +0200 Olaf Hering <olaf@aepfle.de> wrote:

> Fix compilation after incomplete struct net_device changes.

yup, thanks, Kamalesh Babulal has already sent in an identical
patch.
