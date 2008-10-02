Return-Path: <liranrazlinux@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 111B6DDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Oct 2008 04:30:39 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so392072eyi.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Oct 2008 11:30:38 -0700 (PDT)
Message-ID: <e3b3ab5c0810021130t2c3b8d18t817f9ffecd261740@mail.gmail.com>
Date: Thu, 2 Oct 2008 14:30:38 -0400
From: "liran raz" <liranrazlinux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: NOHZ: local_softirq_pending 08
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_70564_10196422.1222972238045"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_70564_10196422.1222972238045
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,

I have a driver that uses the scc1 intertupts.
After enabling the scc1 interrupts I see this message
coming from the kernel for some time:

NOHZ: local_softirq_pending 08
1. What is the meaning of this message? does
2. Does it indicate that something is wrong & need a fix?
3. How can I get rid of it?

(The interrupt is connected to an ISR by using
the standard request_irq() routine).

Kernel 2.6.24
Processor: MPC8272

Thanks,
Liran.

------=_Part_70564_10196422.1222972238045
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><p>hi,</p>
<p>I have a driver that uses the scc1 intertupts.<br>After enabling the scc1 interrupts I see this message<br>coming from the kernel for some time:</p>
<p>NOHZ: local_softirq_pending 08</p>
<div>1. What is the meaning of this message? does<br>2.&nbsp;Does it&nbsp;indicate that something is wrong &amp; need a fix?</div>
<div>3. How can I get rid of it?</div>
<p>(The interrupt is connected to an ISR by using<br>the standard request_irq() routine).</p>
<p>Kernel 2.6.24<br>Processor: MPC8272</p>
<p>Thanks,<br>Liran.<br></p></div>

------=_Part_70564_10196422.1222972238045--
