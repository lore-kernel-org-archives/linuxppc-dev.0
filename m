Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 0/4] A few spufs fixes for .25
Message-Id: <1202446241.799868.442184577655.0.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 08 Feb 2008 15:50:41 +1100
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here are a few spufs fixes & updates for 2.6.25. Let me know if these
are all OK.

Cheers,


Jeremy

---
Christoph Hellwig (1):
      spufs: fix state_mutex leaks

Luke Browning (2):
      spufs: no need to have a runnable SPU for libassist update
      spufs: fix timing dependent false return from spufs_run_spu

Masato Noguchi (1):
      spufs: update SPU_Status[CISHP] in backing runcntl write
