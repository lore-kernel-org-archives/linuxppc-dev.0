Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 80A21DDF04
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 21:26:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Celleb: Support for Power/Reset buttons
Date: Tue, 2 Oct 2007 13:25:57 +0200
References: <20071002.172121.-1625870824.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071002.172121.-1625870824.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710021325.57765.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 October 2007, Ishizaki Kou wrote:
> This is a patch to support Power/Reset buttons on Beat on Celleb.
> 
> On Beat, we have an event from Beat if Power button or Reset button
> is pressed. This patch catches the event and convert it to a signal
> to INIT process by calling ctrl_alt_del() function.
> 
> /sbin/inittab have no entry to turn the machine power off so we have
> to detect if power button is pressed or not internally in our driver.
> This idea is taken from PS3's event handling subsystem.
> 
> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>
