Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B02A8DE17F
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:02:52 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sat, 7 Jul 2007 19:55:07 +0200
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
	<1183827083.3066.64.camel@shinybook.infradead.org>
In-Reply-To: <1183827083.3066.64.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071955.07910.arnd@arndb.de>
Cc: paulus@samba.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, David Woodhouse wrote:
> Can we add properties to indicate the common high-speed modes too? The
> Natsemi baud-base thing could be autodetected by 8250.c if you'd let it,
> but the SMSC trick just has to be set as a UPF_MAGIC_MULTIPLIER flag.

Yes, that sounds good. I do not have enough understanding about the
extra feature to know which ones should get detected with their own
property, so I left that out for the next person that needs it...

	Arnd <><
