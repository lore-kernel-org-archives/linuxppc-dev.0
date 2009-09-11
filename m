Return-Path: <hongwoo7@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4DD96B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 16:34:01 +1000 (EST)
Received: from mail-px0-f195.google.com (mail-px0-f195.google.com
	[209.85.216.195]) by ozlabs.org (Postfix) with ESMTP id BEE49DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 16:33:59 +1000 (EST)
Received: by pxi33 with SMTP id 33so701000pxi.11
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 23:33:57 -0700 (PDT)
Message-ID: <4AA9EF51.1050506@gmail.com>
Date: Fri, 11 Sep 2009 15:33:53 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: RMO ? (in the prom_init.c) 
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ~

Can anybody tell me what the RMO is ?? in the linux kernel. 
(arch/powerpc/kernel/prom_init.c)
Through googling and guessing, I found "Read Memory Only" and "Relaxed 
Memory Order".
But none of these are not properly understood in the context.

Thanks in advance.

HongWoo.
