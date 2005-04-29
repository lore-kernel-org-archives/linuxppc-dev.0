Return-Path: <bobys@tataelxsi.co.in>
Received: from vmail.vsnl.com (v-mail.vsnl.com [202.54.117.17])
	by ozlabs.org (Postfix) with ESMTP id 61EF167A00
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 01:15:34 +1000 (EST)
Received: from bobys ([127.0.0.1])
	by vmail.vsnl.com (iPlanet Messaging Server 5.2 HotFix 1.16 (built May
	14 2003)) with SMTP id <0IFP00FITR0PEF@vmail.vsnl.com> for
	linuxppc-embedded@ozlabs.org; Fri, 29 Apr 2005 20:30:26 +0530 (IST)
Date: Fri, 29 Apr 2005 20:31:13 +0530
From: bobys <bobys@tataelxsi.co.in>
To: linuxppc-embedded@ozlabs.org
Message-id: <007301c54ccc$4a013680$e63ca8c0@telxsi.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: Performance issue - VoIP application on Linux 2.4.22
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everybody,
I have a multithreaded VoIP application in user space and a kernel driver
module on MPC 8248 based board.
During media data transfer( Video Call) I have observed one strange behavior
that at specific interval, cpu utilization is reaching to 100 % and then
rolls back to 0 %.  This behavior repeats at regular intervals of time
during the call.
During this time, data rate and memory utilization is constant throughout
the Call. Also number of interrupts received and processed in the kernel
driver is constant.  We have checked the code many times, but couldn't find
any of the threads/driver hogging the processor time.
We are using Linux kernel 2.4.22  with kernel preemption enabled and low
latency patch added. Please let me know anybody have seen same behavior and
how to sort this out.
Thanks and Regards
Boby
