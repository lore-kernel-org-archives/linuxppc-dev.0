Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 71FFC67B3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:00:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 15 Jun 2005 16:55:14 +0200
Message-ID: <8E342283C2100540AAC5D1030970547766F7A1@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

i'm evaluating IPC on the MPC885ADS and discovered
that the context switching times seem to be quite=20
disappointing (up to 1ms). As we need to do a lot=20
of IPC later on, i'm interested bringing the time=20
down.

Therefore i wonder, if there are any known problems=20
with the MMU on 8xx and 2.4.2x which might explain=20
that?=20

Or is this the expected context switching time for=20
CPU @ 100 MHz (RAM @ 50 MHz)? Suggestions for a=20
benchmark program?

Thanks!

  Peter
