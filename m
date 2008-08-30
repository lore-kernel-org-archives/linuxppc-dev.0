Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 181DFDDE98
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 19:10:33 +1000 (EST)
Received: from [192.168.1.37] (node206.74.251.72.1dial.com [72.251.74.206])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7U995hV017258
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 02:10:26 -0700 (PDT)
Message-ID: <48B90DDD.8030408@hypersurf.com>
Date: Sat, 30 Aug 2008 02:07:42 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/5] Add a cpufreq driver for the IBM PowerPC 750GX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch set adds a cpufreq driver for the IBM PowerPC 750GX processor. It
"should" also work for the 750FX. The patches are:

	1) Add low level PLL config register interface module
	2) Add cpufreq driver for the 750GX
	3) Other PowerPC kernel changes necessary to support the above
	4) Add kernel doc for the completion feature, fix split-man.pl in
	   kernel-doc-nano-HOWTO.txt
	5) Add pll script to interface with pll_if sysfs attribute

These changes are against 2.6.26.

Thanks for all who took the time to review v1!

kevin
