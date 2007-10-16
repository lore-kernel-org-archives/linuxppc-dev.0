Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by ozlabs.org (Postfix) with ESMTP id D3AAFDDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 04:36:47 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id r27so480050ele
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 11:36:45 -0700 (PDT)
Message-ID: <bfa0697f0710161136y7d28ccd6w828f16d30f85ce19@mail.gmail.com>
Date: Tue, 16 Oct 2007 12:36:44 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-dev@ozlabs.org
Subject: Describing devices in the device tree
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm using a modified ep8248e.dts to describe my hardware and I want to
enable the use of 3 standard interrupts.

  1. irq5
  2. timer1
  3. timer2

How bad does this look?
soc --> cpm -->
                       timer {
                               device_type = "timer";
                               compatible = "fsl,mpc8248-timer";
                               interrupts = <c 8 d 8>;
                               interrupt-parent = <&PIC>;
                       };
                       irq5 {
                               device_type = "irq5";
                               compatible = "fsl,mpc8248-irq5";
                               interrupts = <17 8>;
                               interrupt-parent = <&PIC>;
                       };

-Alan
