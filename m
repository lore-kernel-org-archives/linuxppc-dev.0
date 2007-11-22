Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 0E9E3DDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:42:03 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 22 Nov 2007 08:42:00 -0700
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/10] powerpc: Add kexec/kdump support for ppc32
Message-ID: <20071122154159.GA24711@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <foo@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series adds kexec and kdump support for ppc32 in arch/powerpc.
It has been successfully tested on the mpc8548_cds and prpmc2800 platforms.
Mark Greer and I are preparing patches to the kexec-tools package as
well.

These patches apply to current powerpc.git.

Dale Farnsworth
