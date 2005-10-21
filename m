Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 4B5CA68626
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 19:29:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 21 Oct 2005 11:31:10 +0200
Message-ID: <8E342283C2100540AAC5D103097054778A4189@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8xx soft-float userspace ...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

Due to the fact that the in-kernel FPU emulation looks=20
broken on MPC8xx i want to build a complete soft-float
userspace.

While i was successful in compiling a glibc with -mcpu=3D860
and soft-float (and without memset.S) there's still floating
point in there. Does anybody have some pointers what else
needs to be removed?

TIA and best regards,

 Peter=20
