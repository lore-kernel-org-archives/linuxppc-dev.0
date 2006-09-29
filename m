Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4BDC767BCD
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 06:21:21 +1000 (EST)
Date: Fri, 29 Sep 2006 15:20:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: SATA: "unknown partition table" error, fdisk can't fix, works
	in	2.6.13
Message-ID: <20060929152040.6b7c4e3c@localhost.localdomain>
In-Reply-To: <451D7DE8.8020504@freescale.com>
References: <451D7DE8.8020504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Sep 2006 15:11:20 -0500 Timur Tabi <timur@freescale.com> wrote:

> I have a SATA drive attached to a PowerPC 8349E board, using the SIL 3114 controller.  I'm running the latest code from Paul Mackerras (PowerPC maintainer) (2.6.18-blabla).
> 
> I'm experiencing a number of I/O errors with the SATA drive.  fdisk can see the partition table, but when I issue the "w" command, I get this output:
> 
> The odd thing is that this works in 2.6.13, so something is broken.  I don't know if it's a bug in the sata_sil driver, or a configuration issue.  Can anyone help?
> 

Do you use MSDOS or MAC partition (or other) type? Make sure you have
the one you use in the config.

It looks like the arch/powerpc/configs/mpc83* defconfigs enable neither.


-Olof
