Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 9ED4167B1F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 18:36:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 2 May 2005 10:36:05 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D5A@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "bobys" <bobys@tataelxsi.co.in>, <linuxppc-embedded@ozlabs.org>
Subject: RE: Performance issue - VoIP application on Linux 2.4.22
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

bobys wrote:
>Hello everybody,
>I have a multithreaded VoIP application in user space and a kernel
driver
>module on MPC 8248 based board.
>During media data transfer( Video Call) I have observed one strange
>behavior
>that at specific interval, cpu utilization is reaching to 100 % and
then
>rolls back to 0 %.  This behavior repeats at regular intervals of time
>during the call.
>During this time, data rate and memory utilization is constant
throughout
>the Call. Also number of interrupts received and processed in the
kernel
>driver is constant.  We have checked the code many times, but couldn't
find
>any of the threads/driver hogging the processor time.
>We are using Linux kernel 2.4.22  with kernel preemption enabled and
low
>latency patch added. Please let me know anybody have seen same behavior
and
>how to sort this out.

I have no idea with 2.4.x. However, if you have OProfile[1] support
available in your kernel (look for custom module on 2.4), that's quite
easy=20
to spot the cpu utilization burst.

[1] http://oprofile.sf.net


Best Regards
--=20
Stephane

PS: OProfile is a neat tool. We won't thank enough the OProfile team.
