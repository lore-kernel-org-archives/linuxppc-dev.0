Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E8E382C02F4
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 10:30:12 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1SpTXF-0002jA-BD
 for linuxppc-dev@ozlabs.org; Fri, 13 Jul 2012 02:15:05 +0200
Received: from 190-205-147-85.dyn.dsl.cantv.net ([127.0.0.1])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 02:15:05 +0200
Received: from galafel by 190-205-147-85.dyn.dsl.cantv.net with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 02:15:05 +0200
To: linuxppc-dev@ozlabs.org
From: Gal Afel <galafel@gmail.com>
Subject: Using gpio in MPC8309
Date: Fri, 13 Jul 2012 00:08:44 +0000 (UTC)
Message-ID: <loom.20120713T013514-149@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I just got a TWR-MPC8309 from Freescale running Embedded Linux OS. The kernel
version is Linux 2.6.11+pq3 patches and the kernel preconfig file is
linux_2.6.11_mpc8548_cds_def.config.

I'm new to processors running Linux and I'm having a hard time trying to
understand how can I program the GPIO and use them. Is there a tutorial or any
documentation you could provide me to get started on accessing the processor
pins please?

I'm using CodeWarrior Development Studio for Power Architecture version 10.0.2
and I haven't found a library that includes the functions to access the pins
functionality. Is there any documentation you could suggest me to do that please?
