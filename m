Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlr1m5LMyzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 16:12:43 +1000 (AEST)
Received: by mail-wm0-x229.google.com with SMTP id u206so109629142wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 23:12:43 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 14 Apr 2016 08:12:20 +0200
Message-ID: <CA+7wUsymDJZJenG0ok3kXXvpgtDgiWC_aMzwva=-mt1q8O3kQQ@mail.gmail.com>
Subject: ams: Lots of kworker activity after wake from hibernate on Powerbook
To: linuxppc-dev@lists.ozlabs.org
Cc: 798102-forwarded@bugs.debian.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear all,

I am hoping someone could help me diagnose the following bug report:

https://bugs.debian.org/798102

[...]
After waking from hibernate, I get lots of kworker activity that makes my
fans kick in.  Top shows a process called kworker/0:3 always active using
around 3% cpu, and Powertop shows a process using 320 ms/s with the Category
Kwork and the Description ams_worker (Powertop also shows about 33% cpu usage).
I assume ams stands for Apple Motion Sensor, and when I unload the module
"ams" everything returns to normal and my fans quiet down.

This is on an aluminum Powerbook (PowerBook5,6).
[...]


Is there any tool to use to check the behavior of the ams kernel module ?

Thanks much
