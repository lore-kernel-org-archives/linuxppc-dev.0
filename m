Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013231.510168034@samba.org>
Date: Tue, 27 Apr 2010 11:32:31 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 00/15] PowerPC cpumask patches
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a first attempt at converting PowerPC across to the new cpumask
API.  

I need to audit the GFP_ flags of alloc_cpumask_var. There are also a few
areas still to be done: cell, xmon, kexec, crashdump and the cputhreads code

Anton
