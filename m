Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x235.google.com (mail-ea0-x235.google.com
 [IPv6:2a00:1450:4013:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED8452C014C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 01:14:28 +1000 (EST)
Received: by mail-ea0-f181.google.com with SMTP id a15so454290eae.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 08:14:19 -0700 (PDT)
Received: from [109.52.118.51] ([109.52.118.51])
 by mx.google.com with ESMTPSA id n42sm3323020eeh.15.2013.07.16.08.14.18
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 16 Jul 2013 08:14:18 -0700 (PDT)
From: neorf3k <neorf3k@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: force cpu:bus frequency?
Message-Id: <C4163700-C402-4EC3-8357-38ACDAD11792@gmail.com>
Date: Tue, 16 Jul 2013 17:14:16 +0200
To: Linux Ppc Dev List <linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is possibile to force cpu:bus frequency ration in 2.6.33. kernel?
we have a custom board based on mpc5200b. this is our boot:
CPU:   MPC5200B v2.2, Core v1.4 at 132 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
Board: Ran Controller Board
I2C:   85 kHz, ready
DRAM:  128 MB
FLASH: 64 MB

Thank you

Lorenzo
