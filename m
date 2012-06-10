Return-Path: <chmeeedalf@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EE86B6FF4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2012 23:29:39 +1000 (EST)
Received: by qcse14 with SMTP id e14so1682652qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2012 06:29:36 -0700 (PDT)
Date: Sun, 10 Jun 2012 09:29:32 -0400
From: Justin Hibbits <chmeeedalf@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: PowerMac PMU programming
Message-ID: <20120610092932.38857c77@narn.knownspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm working on various PMU bits for FreeBSD (I know, not related to
Linux), but running into some problems, which the Linux crowd may be
able to help with, as it's already solved for Linux.  I've managed to
get it to sleep for performing the sleep operation and for the CPU speed
switch on MPC7455-based machines, but it goes catatonic, not waking
up.  I've installed the reset vector pointer at 0x0080, which both OS X
and Linux do, and flush the caches, but no luck.  During development of
the Linux driver was this ever encountered?  Any assistance would be
greatly appreciated, I've been banging my head against this off and on
for about 8 months now.

Thanks for any assistance.  I'm not subscribed to the list, so please
keep my address in replies.

Justin Hibbits
