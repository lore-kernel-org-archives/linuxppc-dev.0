Return-Path: <Adam.Zajac@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 691EF2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 07:30:58 +1000 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id i9ILWHG2028008
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Oct 2004 14:32:17 -0700 (MST)
Received: from tx14exm06.ftw.mot.com (tx14exm06.ftw.mot.com [10.63.167.204])
	by il06exr04.mot.com (Motorola/il06exr04) with ESMTP id i9ILTgIk032554
	for <linuxppc-embedded@ozlabs.org>; Mon, 18 Oct 2004 16:29:42 -0500
Message-ID: <EFB813091B18D511BD3600508B644F820A6181E7@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 18 Oct 2004 16:30:54 -0500
MIME-Version: 1.0
Content-Type: text/plain
Subject: Help on tuning the Linux kernel for soft real-time requirements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, 

I'm seeking any help on tuning the Linux kernel running in an embedded
environment to meet some of the soft real-time requirements that we have for
our platform.
Our custom board is based on PPC MPC8540 processor and it runs kernel 2.4.20
with the low-latency patch and kernel preemption enabled. The applications
running on that board keep experiencing a "task starvation" scenario, which
leads to missing soft real-time deadline requirements.

We've tried to prioritize the applications that needed to meet these soft
real-time deadlines above other "background" tasks performing unarchiving
operations (gzip + tar) through the means of adjusting dynamic as well as
static priorities. Dynamic priorities were assigned through "nice()"
function and static priorities were assigned for the round robin policy of
the scheduler through "sched_setscheduler()". We've pretty much exhausted
all combinations of the priority assignments without finding the right
configuration that would satisfy both soft real-time deadlines and overall
system performance requirements.
Soft real-time deadlines are being missed during unarchiving procedures. 

Any hints and ideas would be greatly appreciated. 

Regards, 
Adam Zajac 
