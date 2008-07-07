Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 7132DDE00F
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 21:48:11 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so925078ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 04:48:08 -0700 (PDT)
Message-ID: <48720279.6010904@genesi-usa.com>
Date: Mon, 07 Jul 2008 12:48:09 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: e600 core power management
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

Quick question, am I right (and looking at idle_6xx.S, I think I am) in thinking that
during the idle process, by default, an e600 core such as the 7448 or MPC8610 will
automatically transition to a NAP state, thus being as low power as possible?

Has anyone done any benchmarking of the power consumption of the processor when
this transition is disabled (remove CPU_FTR_MAYBE_CAN_NAP) or have a rough idea
what the benefits might be?

Is there a performance reason for removing the feature or disabling naps altogether?
The powersave-nap sysctl controls whether DOZE or NAP is entered on processors that
support a seperate HID0[DOZE], however is it possible to extend it such that nap
is never entered?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
