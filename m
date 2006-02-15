Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 55034679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 10:51:14 +1100 (EST)
Message-ID: <43F3BE4A.7070603@ovro.caltech.edu>
Date: Wed, 15 Feb 2006 15:50:34 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: PowerQUICC II Pro MPC8349E-MDS Linux 2.6 support
References: <Pine.LNX.4.44.0602151722050.30048-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602151722050.30048-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Kumar,

I saw your email earlier, so figured you were listening in
on the PPC group at the moment.

In the recent 2.6 kernel source, you authored the file:

arch/ppc/platforms/83xx/mpc834x_sys.h and .c

are these files for the MPC8349E-MDS board?

In the Denx source, there is modified versions for the
TQM board, but I wasn't sure what platform the original
files were targeted for.

Thanks,
Dave Hawkins,
Caltech.
