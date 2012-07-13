Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
 by ozlabs.org (Postfix) with ESMTP id 9FCB42C036F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 22:02:43 +1000 (EST)
Message-ID: <50000D2F.8030905@mlbassoc.com>
Date: Fri, 13 Jul 2012 05:57:35 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Using gpio in MPC8309
References: <loom.20120713T013514-149@post.gmane.org>
In-Reply-To: <loom.20120713T013514-149@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012-07-12 18:08, Gal Afel wrote:
> Hello,
>
> I just got a TWR-MPC8309 from Freescale running Embedded Linux OS. The kernel
> version is Linux 2.6.11+pq3 patches and the kernel preconfig file is
> linux_2.6.11_mpc8548_cds_def.config.

That's a really OLD kernel, plus it doesn't seem to match your hardware.
MPC8309 is a very different beast from the MPC8548.

>
> I'm new to processors running Linux and I'm having a hard time trying to
> understand how can I program the GPIO and use them. Is there a tutorial or any
> documentation you could provide me to get started on accessing the processor
> pins please?
>
> I'm using CodeWarrior Development Studio for Power Architecture version 10.0.2
> and I haven't found a library that includes the functions to access the pins
> functionality. Is there any documentation you could suggest me to do that please?

Try looking at the Linux kernel source file 'Documentation/gpio.txt'

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
