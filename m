Return-Path: <vneethv@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39DEEB70C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Sep 2011 21:43:31 +1000 (EST)
Received: by bkbzu17 with SMTP id zu17so3280746bkb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Sep 2011 04:43:26 -0700 (PDT)
MIME-Version: 1.0
From: Vineeth <vneethv@gmail.com>
Date: Fri, 16 Sep 2011 17:13:06 +0530
Message-ID: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
Subject: Timer interrupt on Linux 3.0.3
To: linux-embedded@vger.kernel.org, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00151747b5aa5a127204ad0d80f0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00151747b5aa5a127204ad0d80f0
Content-Type: text/plain; charset=ISO-8859-1

Hi,

We are porting Linux on MPC7410 based board. As there was some issue with
the processor DECrementer and timebase registers, we were using an external
count down timer as our DECementer. We used timer_interrupt() function in
arch/powerpc/kernel/time.c as our interrupt handler. Things were working
fine.

lately we moved to Linux 3.0.3. What we found was even without a proper
timer, the kernel with initramfs worked (except the calls like sleep,delay
ofcourse); Is there any major difference in the scheduler ? or the way
context switch happens ? is it not depended on the timer interrupt or the
timer ??

Thanks
Vineeth

--00151747b5aa5a127204ad0d80f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>We are porting Linux on MPC7410 based board. As there was some i=
ssue with the processor DECrementer and timebase registers, we were using a=
n external count down timer as our DECementer. We used timer_interrupt() fu=
nction in arch/powerpc/kernel/time.c as our interrupt handler. Things were =
working fine.<br>

<br>lately we moved to Linux 3.0.3. What we found was even without a proper=
 timer, the kernel with initramfs worked (except the calls like sleep,delay=
 ofcourse); Is there any major difference in the scheduler ? or the way con=
text switch happens ? is it not depended on the timer interrupt or the time=
r ??<br>

<br>Thanks<br>Vineeth<br>

--00151747b5aa5a127204ad0d80f0--
