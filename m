Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B5DEDDDED4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 06:12:00 +1100 (EST)
Date: Thu, 2 Apr 2009 23:11:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] QE USB Host Integration for MPC832x
Message-ID: <20090402191159.GA14626@oksana.dev.rtsoft.ru>
References: <1238622396-9768-1-git-send-email-marcel@ziswiler.com>
	<20090402183357.GA29050@oksana.dev.rtsoft.ru>
	<20090402183631.GA6699@oksana.dev.rtsoft.ru>
	<49D5071D.50001@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49D5071D.50001@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Marcel Ziswiler <marcel@ziswiler.com>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2009 at 01:42:37PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > Oh, I was wrong. fsl_qe_udc driver uses mpc8360 compatible for
> > matching, so you can't remove it. :-/
> 
> Ugh, that's a bug in the driver then.

Yes, but that depends on what chip was the first one? MPC8323 or
MPC8360?

> My understanding is that the only MPC8323 QE microcode update is the one
> for UART.  If there are any updates to any other QE devices for standard
> functionality, I'm not aware of any.

I found them:

http://www.freescale.com/files/netcomm/software/app_software/microcode/QERAMPTCH.zip?fpsp=1

File is qe_usb3-8323_Rev11.c

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
