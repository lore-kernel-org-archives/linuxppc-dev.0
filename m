Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id CB077DDE35
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 22:26:23 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at initializing
	SLB
Date: Wed, 26 Sep 2007 14:15:34 +0200
References: <20070926.132034.-1300539325.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070926.132034.-1300539325.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261415.35404.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Ishizaki Kou wrote:
> This is a workaround NOT to insert EA=0 entry at initializing SLB.
> Without this patch, you can see /sbin/init hanging at a machine
> which has less or equal than 256MB memory.

Can you elaborate? I don't understand why /sbin/init will hang
because of an incorrect SLB entry, or how that entry gets
initialized from get_paca()->kstack.

Are you still trying to find a better fix for 2.6.24, or do
you intend to have this patch go in for now?

Also, I did not get a patch 4/7 and 5/7. Did you send them to
some other mailing list, or did they get lost on the way?

	Arnd <><
