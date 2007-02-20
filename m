Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 2FA78DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 21:00:35 +1100 (EST)
Subject: Re: Porting JFFS2 to 2.4.6 kernel
From: Thomas Gleixner <tglx@linutronix.de>
To: Sendhilraj T <Sendhilraj.T@Lntemsys.com>
In-Reply-To: <OF73EC41DC.A2A75D66-ON65257283.003F718B-65257283.003F5CF1@lntemsys.com>
References: <OF73EC41DC.A2A75D66-ON65257283.003F718B-65257283.003F5CF1@lntemsys.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:39:49 +0100
Message-Id: <1171964390.30834.223.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
Reply-To: tglx@linutronix.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 17:03 +0530, Sendhilraj T wrote:
> 
> Hello All, 
> 
> Now I created a new patch file to support JFFS2 in 2.4.6 from 2.4.16. 

As Arnd already pointed out 2.4.6 is a known to be broken kernel. Please
use an up to date kernel and folks will help you. If you insist on using
this ancient stuff, please figure it out yourself.

	tglx
