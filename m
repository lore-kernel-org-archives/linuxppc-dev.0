Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7B55DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 19:34:45 +1000 (EST)
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20070928.170401.-1300520897.kouish@swc.toshiba.co.jp>
References: <20070928.170401.-1300520897.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 19:29:04 +1000
Message-Id: <1190971744.6158.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-09-28 at 17:04 +0900, Ishizaki Kou wrote:
> Commit edd0622bd2e8f755c960827e15aa6908c3c5aa94 seems to break the
> kernel and commit 175587cca7447daf5a13e4a53d32360ed8cba804 backs out
> the symptom.  Calling slb_flush_and_rebolt() at slb_initialize()
> function breaks the SLB table since it is called before setting up
> PACA.
> 
> Thank you for your hint.

Ah yes, there was a temporary breakage there that got fixed indeed,
I remember.

Cheers,
Ben.
