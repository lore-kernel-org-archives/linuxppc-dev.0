Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4C97DDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 09:43:50 +1000 (EST)
Subject: Re: [patch 21/33] PS3: Use clear_bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46730D51.1060709@am.sony.com>
References: <20070615204749.629571012@am.sony.com> >
	<46730D51.1060709@am.sony.com>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 09:43:36 +1000
Message-Id: <1181951017.26853.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-15 at 15:06 -0700, Geoff Levand wrote:
> Replace the inline asm with bitops in the PS3 interrupt
> chip mask routines.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
