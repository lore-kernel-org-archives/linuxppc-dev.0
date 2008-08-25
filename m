Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 32D2DDDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 20:03:31 +1000 (EST)
Message-ID: <48B282E8.4070807@hypersurf.com>
Date: Mon, 25 Aug 2008 03:01:12 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] A a cpufreq driver for the IBM PowerPC 750GX
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch set adds a cpufreq driver for the IBM PowerPC 750GX processor. It
"should" also work for the 750FX. The patches are:

	1) Add low level PLL config register interface module
	2) Add cpufreq driver for the 750GX
	3) Other PowerPC kernel changes necessary to support the above
	4) Add kernel doc for the completion feature, fix split-man.pl in
	   kernel-doc-nano-HOWTO.txt

These changes are against 2.6.26.
