Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDC406877A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 05:53:33 +1100 (EST)
Date: Tue, 15 Nov 2005 19:53:26 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051115185326.GA13782@suse.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<1131834336.7406.46.camel@gaston>
	<71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
	<1131915560.5504.67.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1131915560.5504.67.camel@gaston>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ppc-dev list <linuxppc-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Nov 14, Benjamin Herrenschmidt wrote:

> On Sun, 2005-11-13 at 10:37 -0600, Kumar Gala wrote:
> 
> > Can we please add some defconfigs for arch/powerpc to possibly help  
> > with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
> > bit configs would be a good start.
> 
> The 64 bits defconfigs are there already. I'll do a pmac one.

Can you move also arch/ppc64/defconfig into arch/powerpc/configs/?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
