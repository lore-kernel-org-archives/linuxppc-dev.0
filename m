Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B19A567A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 10:54:25 +1100 (EST)
Date: Wed, 15 Feb 2006 17:45:25 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: PowerQUICC II Pro MPC8349E-MDS Linux 2.6 support
In-Reply-To: <43F3BE4A.7070603@ovro.caltech.edu>
Message-ID: <Pine.LNX.4.44.0602151743030.450-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 15 Feb 2006, David Hawkins wrote:

> 
> Hi Kumar,
> 
> I saw your email earlier, so figured you were listening in
> on the PPC group at the moment.
> 
> In the recent 2.6 kernel source, you authored the file:
> 
> arch/ppc/platforms/83xx/mpc834x_sys.h and .c
> 
> are these files for the MPC8349E-MDS board?

Yes, Freescale names the board four different things durings its 
development (ADS, SYS, MDS, ok maybe only three :)

> In the Denx source, there is modified versions for the
> TQM board, but I wasn't sure what platform the original
> files were targeted for.

Not sure, I follow.  The MPC834x MDS was the first 834x system supported.

However, if you are looking at 834x, I recommend you grab my u-boot tree 
from kernel.org since it has support for booting the kernel with a flat 
device tree.  From 2.6.16, all future 83xx work will be done in 
arch/powerpc which requires a flat dev tree to boot.

- kumar
