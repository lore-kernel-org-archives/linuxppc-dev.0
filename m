Return-Path: <neorf3k@gmail.com>
Received: from mail-ee0-x233.google.com (mail-ee0-x233.google.com
 [IPv6:2a00:1450:4013:c00::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82BBC2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 06:23:29 +1100 (EST)
Received: by mail-ee0-f51.google.com with SMTP id t10so3395868eei.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 11:23:24 -0800 (PST)
Received: from [192.168.0.100] (adsl-ull-89-173.40-151.net24.it.
 [151.40.173.89])
 by mx.google.com with ESMTPSA id k7sm71073731eeg.13.2013.11.12.11.23.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 12 Nov 2013 11:23:22 -0800 (PST)
From: neorf3k <neorf3k@gmail.com>
Content-Type: text/plain; charset=windows-1252
Subject: Problem reading and programming memory location...
Message-Id: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
Date: Tue, 12 Nov 2013 20:23:20 +0100
To: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

we have tried to read and program an 8bit register with 32bit address. =
we have mapped it with: ioremap, kmalloc etc=85 and then using: outb, =
iowrite8 etc.. but when we write to it, the value doesn=92t change=85 =
with other memory location is ok.
That is an 8 bit register, located at 0x10020000 in a mpc5200b =
architecture. we are using kernel 2.6.33.=20
what could be?
Thank you

Lorenzo=
