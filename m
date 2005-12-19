Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id E2B7B688D5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 19:57:49 +1100 (EST)
Received: from linuxdev.ECRIN-CROLLES (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 5D79425C7AA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 09:57:47 +0100 (CET)
Date: Mon, 19 Dec 2005 10:00:59 +0100
From: Nathael Pajani <nathael.pajani@cpe.fr>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051219085747.5D79425C7AA@smtp-out.completel.net>
Subject: [PATCH] powerpc: CPM2 interrupt handler failure after 100,000
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 interrupts
Message-Id: <20051219100059.5a95533f.nathael.pajani@cpe.fr>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi!

Hum.. in the patch you moved from "void" to "int":
>-static void cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
>+static int cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)

But should'nt it be "irqreturn_t" ?
static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)

+++
Have fun :)
----=20
Nathael PAJANI
Ing=E9nieur CPE Lyon
nathael.pajani@cpe.fr
