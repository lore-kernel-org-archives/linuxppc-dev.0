Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 9F15E2BE83
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Nov 2004 16:42:54 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D4D14D42-2BC8-11D9-A949-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 31 Oct 2004 23:42:34 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, anton@au.ibm.com
Subject: Added number of PMRs to cpu_specs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Andy F. is adding 'proper' oprofile support to PPC32.  I was wondering 
if you had any issue if we added the # of PMRs a cpu has to the 
cpu_specs table.  I figured it better that we keep all such info in a 
single place, rather than reproducing PVR based checks in multiple 
places.

Note, PPC64 currently does a PVR based check in arch/ppc64/common.c.  I 
would recommend that model->num_counters come from cpu_specs and 
oprof_ppc64_ops.cpu_type be composed from cpu_specs.cpu_name.

- kumar
