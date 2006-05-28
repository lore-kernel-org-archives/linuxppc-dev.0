Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2116E679E1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 02:12:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: add dmesg command to xmon
Date: Sun, 28 May 2006 18:12:08 +0200
References: <20060528104621.GA7126@suse.de> <200605281404.26070.arnd@arndb.de>
	<20060528120748.GA7608@suse.de>
In-Reply-To: <20060528120748.GA7608@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605281812.09308.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 28 May 2006 14:07, Olaf Hering wrote:
> > This whole function looks fishy to me. It seems unnecessarily rude to me to
> > use kallsyms_lookup_name in order to get at a static variable from another
> > file. Can't you instead add a global function to kernel/printk.c to return
> > the buffer?
> 
> Its possible, but it wont end up in Linus tree.

Hmm, so the idea is that because Linus doesn't like kernel debuggers, we just
obfuscate the code for any improvements to xmon and hope he doesn't notice?

Don't get me wrong, I think having dmesg in xmon is a good idea, but this is
probably not the best strategy of getting it in there.

	Arnd <><
