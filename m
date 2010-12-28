Return-Path: <jjdanimoth@gmail.com>
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com
	[209.85.218.42]) by ozlabs.org (Postfix) with ESMTP id 49BC9B70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Dec 2010 23:26:08 +1100 (EST)
Received: by yia28 with SMTP id 28so2842365yia.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Dec 2010 04:26:06 -0800 (PST)
MIME-Version: 1.0
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 28 Dec 2010 13:25:44 +0100
Message-ID: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
Subject: PMU_IOC_SLEEP failed
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

Hi all,

what could be the problem here?

[root@myhost ~]# /usr/lib/hal/hal-system-power-pmu sleep
power-pmu : PMU_IOC_SLEEP failed

(same with pm-suspend, kernel version: any >= 2.6.33. I'm now on a .37-rc).

KMS is disabled (modprobe radeon modeset=0, and I can't switch over VT).
userspace thing has kms for radeon disabled (libdrm, mesa, xf86-video-ati).

There are some important parts of config should I attach?

Thanks
