Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 6409BB6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 05:54:49 +1000 (EST)
Received: by vws20 with SMTP id 20so4803585vws.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 12:54:47 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
From: Timur Tabi <timur@freescale.com>
Date: Tue, 29 Jun 2010 14:54:17 -0500
Message-ID: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
Subject: CONFIG_NO_HZ causing poor console responsiveness
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm adding support for a new e500-based board (the P1022DS), and in
the process I've discovered that enabling CONFIG_NO_HZ (Tickless
System / Dynamic Ticks) causes significant responsiveness problems on
the serial console.  When I type on the console, I see delays of up to
a half-second for almost every character.  It acts as if there's a
background process eating all the CPU.

I don't have time to debug this thoroughly at the moment.  The problem
occurs in the latest kernel, but it appears not to occur in 2.6.32.

Has anyone else seen anything like this?

-- 
Timur Tabi
Linux kernel developer at Freescale
