Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9B90DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 07:51:13 +1000 (EST)
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id n3RLoWsf025858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:51:08 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	n3RLoWv1024742
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 14:50:32 -0700
Date: Mon, 27 Apr 2009 14:50:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linuxppc-dev@ozlabs.org
Subject: drivers/video/logo/logo_linux_mono.c build error
Message-Id: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


powerpc allmodconfig, current mainline:

drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data causes a section type conflict

switching it from __initconst to __initdata "fixes" it.

I'm (illegally) using gcc-4.1.0.

I assume this is an FAQ but I don't know what the A is ;)
