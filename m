Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05E29B6FEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2012 07:44:22 +1000 (EST)
Message-ID: <1335390257.21961.53.camel@pasglop>
Subject: Re: Regression in 32-bit ppc kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Date: Thu, 26 Apr 2012 07:44:17 +1000
In-Reply-To: <4F98117C.7080309@lwfinger.net>
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-25 at 10:00 -0500, Larry Finger wrote:
> 
> After a few tries, I managed to change over to pata_macio.
> Fortunately, most of 
> the system used dev-by-id or UUID, thus most of the process was
> getting all the 
> kernel pieces built in.
> 
> Unfortunately, the original problem remains. I have resumed the
> bisecting - only 
> 11 steps to go. I should have it by Friday! :)
> 
Thanks !

Do we know what the bad interrupt maps to ? Also what is the value of
NR_IRQ and do you have SPARSE_IRQ enabled ? Can you try with the latter
disabled and NR_IRQ set to something large, such as 128 ?

(You may be able to check the interrupt mapping in debugfs)

Cheers,
Ben.
