Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 87CA367E87
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 23:27:38 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [1/17] cell: SPU register lock
Date: Tue, 12 Dec 2006 13:27:29 +0100
References: <200612120303.kBC33vDC016599@toshiba.co.jp>
In-Reply-To: <200612120303.kBC33vDC016599@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612121327.30487.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 04:03, Ishizaki Kou wrote:
> spu->register_lock should be held before accessing registers.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
