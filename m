Return-Path: <g.liakhovetski@gmx.de>
Date: Sun, 21 May 2006 20:36:36 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linuxppc-dev@ozlabs.org
Subject: TI_LOCAL_FLAGS definition wrong?
Message-ID: <Pine.LNX.4.60.0605212033480.11693@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Is this define in arch/ppc/kernel/asm-offsets.c (as of 2.6.17-rc3):

	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, flags));

correct? Or should it be local_flags? Or is it already fixed in later 
versions?

Thanks
Guennadi
---
Guennadi Liakhovetski
