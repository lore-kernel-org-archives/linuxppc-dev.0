Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 7FEAADDEC7
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 07:37:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Discontiguous Memory for MPC85xx Series
Date: Tue, 14 Aug 2007 17:37:12 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108DF1D41@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.1682.1187119378.2006.linuxppc-dev@ozlabs.org>
References: <mailman.1682.1187119378.2006.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am working on a separate project where there is a
discontiguous physical memory map . In looking at
solutions, it looks like the way to go is to=20
use something like a SPARSEMEM option.=20

FWIW, it even mentions something about discontinuous=20
memory in the Device Tree example about the 970 CPU
(Documentation/powerpc/booting-without-of.txt)

I am wondering if there is an implementation for
SPARSEMEM or DISCONTIGMEM being worked on in the=20
powerpc branch that I could use for the mpc85xx family?=20

Or does somebody have another suggestion on how=20
I would do this?

Thanks in advance you can suggest!

Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
(781) 266 - 3567
