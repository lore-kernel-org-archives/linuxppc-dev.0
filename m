Return-Path: <wilbur512@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7286AB7B9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 01:56:49 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id C7270DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 01:56:48 +1000 (EST)
Received: by ywh1 with SMTP id 1so1557576ywh.9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 08:56:45 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Aug 2009 23:56:44 +0800
Message-ID: <e997b7420908270856p6e729d44w4535d8bf6b2ac02a@mail.gmail.com>
Subject: Does kexec support SMP on powerpc? E500 V2
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was a patch of kexec on SMP mips 64 , and I attempt to implement
kexec on SMP powerpc .

I found that ,  it was a little different with  mips when booting a
kernel. We know  that, every CPU jumped directly into kernel on

mips, but on powerpc , E500 SMP,  the 'master' CPU was in charge of
'slave'  CPUs , so 'slave' CPU  could do nothing

but to  wait for 'master'  to wake him up in Init function.


How to implement kexec on SMP powerpc?


Any suggestions would be appreciate

regards,
