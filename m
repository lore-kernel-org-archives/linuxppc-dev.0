Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 1DA80DDE1F
	for <linuxppc-dev@ozlabs.org.>; Sat, 11 Aug 2007 11:43:43 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id k20so788678rvb
	for <linuxppc-dev@ozlabs.org.>; Fri, 10 Aug 2007 18:43:41 -0700 (PDT)
Message-ID: <5c9cd53b0708101843q1b39bccfv10e98eccaa834c91@mail.gmail.com>
Date: Fri, 10 Aug 2007 21:43:41 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org.
Subject: Early UART setup on 2.6 kernel for mpc85xx
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1474_28324591.1186796621840"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1474_28324591.1186796621840
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

In order to debug the kernel 2.6, I want setup serial port with UART on
mpc85xx as early as possible. I add the register access code at the
beginning of  platform_init(). For example, I try to write THR
register(0xe0004500). However the system just hanging there with this line.
If I comment out this line, everything works fine.

Here is the code my mpc85xx_cds_common.c:

void __init
platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
                   unsigned long r6, unsigned long r7)
{

....
}

------=_Part_1474_28324591.1186796621840
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>In order to debug the kernel 2.6, I want setup serial port with UART on mpc85xx as early as possible. I add the register access code&nbsp;at the beginning of &nbsp;platform_init(). For example, I try to write THR register(0xe0004500). However the system just hanging there with this line. If I comment out this line, everything works fine. 
</div>
<div>&nbsp;</div>
<div>Here is the code my mpc85xx_cds_common.c:</div>
<div>&nbsp;</div>
<div>void __init</div>
<div>platform_init(unsigned long r3, unsigned long r4, unsigned long r5, </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long r6, unsigned long r7)</div>
<div>{</div>
<div>&nbsp;</div>
<div>....</div>
<div>}&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_1474_28324591.1186796621840--
