Return-Path: <codevana@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id D811367B26
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 13:10:21 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 37so1084696wra
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 20:10:19 -0700 (PDT)
Message-ID: <7cb1293c0606192010o1c4ebbdfw3719fcef8dcefd94@mail.gmail.com>
Date: Mon, 19 Jun 2006 20:10:19 -0700
From: "Srinivas Murthy" <codevana@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Synch question 2.6.x
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_64283_8022425.1150773019635"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_64283_8022425.1150773019635
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
 I have this 2.6.x kernel mode component for which I have question regarding
the synch reqmt. between workqueues (or tasklets) and kernel threads. The
kernel threads are created from within the kernel module and there is no
user-mode side to them.

 I share some global data in the kernel space that is accessed by the kernel
thread and a work queue (or a tasklet) (kicked off of an isr top-half and
also off of a kernel thread).

 Is there a need to synch access to this data if the preemption is off. What
if the premption is turned on?

 In the case of workq's, if the synch is reqd, are down_xx() up_xx(),
primitives the right ones to use?

Thanks much in advance.

_Srinivas

------=_Part_64283_8022425.1150773019635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;I have this 2.6.x kernel mode component for which I have question regarding the synch reqmt. between workqueues (or tasklets) and kernel threads. The kernel threads are created from within the kernel module and there is no user-mode side to them.
</div>
<div>&nbsp;</div>
<div>&nbsp;I share some global data in the kernel space that is accessed by the kernel thread and a work queue (or a tasklet)&nbsp;(kicked off of an isr top-half and also off of a kernel thread).</div>
<div>&nbsp;</div>
<div>&nbsp;Is there a need to synch access to this data if the preemption is off. What if the premption is turned on?</div>
<div>&nbsp;</div>
<div>&nbsp;In the case of workq's, if the synch is reqd,&nbsp;are down_xx() up_xx(), primitives the right ones to use? </div>
<div>&nbsp;</div>
<div>Thanks much in advance.</div>
<div>&nbsp;</div>
<div>_Srinivas</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_64283_8022425.1150773019635--
