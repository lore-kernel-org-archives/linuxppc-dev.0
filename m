Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6427FDDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 22:15:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8EB7nhj026285
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:07:49 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8ECFYsx496098
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 06:15:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8ECFYu1000958
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 06:15:34 -0600
Date: Fri, 14 Sep 2007 07:15:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: sivaji <rameshmrm@gmail.com>
Subject: Re: Section mismatch warning
Message-ID: <20070914071532.54c60a95@weaponx.rchland.ibm.com>
In-Reply-To: <12673863.post@talk.nabble.com>
References: <12673863.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2007 05:01:14 -0700 (PDT)
sivaji <rameshmrm@gmail.com> wrote:

> 
> Hi,
>          When compiling the kernel 2.6.23-rc4 for our custom board based on
> MPC8641, I got following warning messages
> 
> WARNING: vmlinux.o(.text+0x169f6): Section mismatch: reference to
> .init.data:boot_command_line (between 'note_bootable_part' and
> 'pmac_restart')
> WARNING: vmlinux.o(.text+0x16a02): Section mismatch: reference to
> .init.data:boot_command_line (between 'note_bootable_part' and
> 'pmac_restart')
> WARNING: vmlinux.o(.text+0x16a12): Section mismatch: reference to
> .init.data:boot_command_line (between 'note_bootable_part' and
> 'pmac_restart')
> 
>  Give some idea to fix these warnings.

These should be fixed for 2.6.24

josh
