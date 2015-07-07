Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491BA1A1079
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:56:58 +1000 (AEST)
Received: from [192.168.1.106] (ppp-93-104-86-142.dynamic.mnet-online.de
 [93.104.86.142]) by smtp.strato.de (RZmta 37.8 DYNA|AUTH)
 with ESMTPSA id 604ed7r67Aorxvv
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 7 Jul 2015 12:50:53 +0200 (CEST)
Message-ID: <559BAF0D.4020207@xenosoft.de>
Date: Tue, 07 Jul 2015 12:50:53 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
References: <1428985683-24767-1-git-send-email-dja@axtens.net>
 <1428985683-24767-9-git-send-email-dja@axtens.net>
In-Reply-To: <1428985683-24767-9-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Linuxppc-dev mailing list,

I compiled a kernel from the git on Tuesday 23rd of June 2015. It didn't 
boot with my PASEMI PA6T board.

Error messages:

Oops: Kernel access of bad area, sig: 11 [#1]

.sb600_8259_cascade+0x4c/0xac (unreliable)
.schedule+0x74/0x9c (unreliable)

Kernel panic - not syncing: Fatal exception in interrupt

I compiled the RC1 of kernel 4.2 last Sunday. Unfortunately it didn't 
boot either. The kernel 4.1 and 4.1.1 boot without any problems.

Could someone please explain me why it doesn't boot anymore?

I would like to thank you very much in advance for helping me.

If you have any questions, please don't hesitate to ask. I'm looking 
forward to getting your reply.


Kind regards,

Christian Zigotzky
