Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 42C40679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 07:03:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Unify ppc syscall tables
Date: Mon, 19 Jun 2006 23:03:50 +0200
References: <jefyi050z3.fsf@sykes.suse.de>
In-Reply-To: <jefyi050z3.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606192303.50991.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 19 June 2006 22:45, Andreas Schwab wrote:
> Avoid duplication of the syscall table for the cell platform. =A0Based on=
 an
> idea from David Woodhouse.

Nice one, thanks for revisiting this!

> Signed-off-by: Andreas Schwab <schwab@suse.de>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
