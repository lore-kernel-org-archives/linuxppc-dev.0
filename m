Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 523DB67A7F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 00:58:31 +1100 (EST)
Date: Fri, 28 Jan 2005 14:58:27 +0100
From: Olaf Hering <olh@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dtor_core@ameritech.net>
Message-ID: <20050128135827.GA28784@suse.de>
References: <20050128132202.GA27323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050128132202.GA27323@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jan 28, Olaf Hering wrote:

> 
> My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():

It fails also on PReP, not only on CHRP. 2.6.10 looks like this:

Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
atkbd.c: keyboard reset failed on isa0060/serio1
atkbd.c: keyboard reset failed on isa0060/serio0

I'm able to break into xmon, cpu is in cpu_idle, maybe its spinning
somewhere.
