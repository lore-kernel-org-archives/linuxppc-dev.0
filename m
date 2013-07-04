Return-Path: <neorf3k@gmail.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com
 [IPv6:2a00:1450:400c:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0137A2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 19:32:04 +1000 (EST)
Received: by mail-wg0-f44.google.com with SMTP id m15so933222wgh.23
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jul 2013 02:32:00 -0700 (PDT)
Received: from [109.52.126.4] ([109.52.126.4])
 by mx.google.com with ESMTPSA id fb2sm33435662wic.4.2013.07.04.02.31.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 04 Jul 2013 02:31:59 -0700 (PDT)
From: Lorenzo Forzini <neorf3k@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: help with custom board based on mpc5200b
Message-Id: <26BF10C8-C181-4FEA-9314-7D8D3C1AB4FD@gmail.com>
Date: Thu, 4 Jul 2013 11:31:54 +0200
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, we're using a custom board based on mpc5200b

We are using kernel 2.6.33 and when we using ethernet, we get 80% packet =
loss with ping.
Where could i find the solutions?

U-boot information:
CPU:   MPC5200B v2.2, Core v1.4 at 132 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
Board: Ran Controller Board

I2C:   85 kHz, ready

Thanks

Lorenzo=
