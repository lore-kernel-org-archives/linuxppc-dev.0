Return-Path: <Thomas.Waldecker@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [82.210.228.1])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "IronPort Appliance Demo Certificate",
 Issuer "IronPort Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFC372C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 23:17:16 +1100 (EST)
From: Thomas Waldecker <Thomas.Waldecker@tqs.de>
To: "Linux PPC dev mailing list (linuxppc-dev@lists.ozlabs.org)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Why is the e500v2 core  not using cpuidle?
Date: Fri, 1 Feb 2013 12:06:05 +0000
Message-ID: <B88C075EE1324644BA0452D5EFDD58281395211D@TQ-MAIL.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

As part of my masterthesis I was just looking around the kernel=20
sources for cpuidle and figured out that the only CPU in the PowerPC=20
architecture using the cpuidle framework is the pseries.

I assume the e500v2 core is using the idle modes=20
in arch/powerpc/kernel/idle_e500.S

Why is there no support for the cpuidle framework?

How can I debug the e500 idle modes?=20
Are there any statistics?

I already ran PowerTOP on a QorIQ P2020 but it's almost useless=20
because the information is missing.

Kind regards,
Thomas Waldecker
