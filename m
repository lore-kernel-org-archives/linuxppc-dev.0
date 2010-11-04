Return-Path: <jjdanimoth@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id D02271007D2
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2010 07:14:31 +1100 (EST)
Received: by iwn5 with SMTP id 5so2448978iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Nov 2010 13:14:30 -0700 (PDT)
MIME-Version: 1.0
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Thu, 4 Nov 2010 21:14:07 +0100
Message-ID: <AANLkTimnxBrVoiyhrd3Sazwo++JCh7XfexDkcnqKX0dQ@mail.gmail.com>
Subject: Pb G4: Suspend-to-RAM doesn't work for aTi users
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello to all,

I read somewhere (ati-dri devel ml, maybe?) that suspend on aTi
machines was broken with KMS, and I have exactly this problem. It is
fixed now, so maybe I have some bad conf file? Or this feature isn't
implemented yet?

I have these errors:

[root@jim ~]# echo 'mem' > /sys/power/state
-bash: echo: write error: No such device

[root@jim bin]# ./pm-pmu --check && echo "yes"
[root@jim bin]#

[root@jim bin]# /usr/lib/hal/hal-system-power-pmu sleep
power-pmu : PMU_IOC_SLEEP failed

[root@jim bin]# uname -r
2.6.35-ARCH

Nvidia users can sleep with happiness.
Thank you
