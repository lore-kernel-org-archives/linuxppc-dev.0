Return-Path: <mail4mz@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 48693DE090
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 04:29:01 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2297394pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 11:29:00 -0700 (PDT)
Message-ID: <5c9cd53b0804151129s2006af68n79975e8a8c07177b@mail.gmail.com>
Date: Tue, 15 Apr 2008 14:29:00 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: MCC problem of MPC8568
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Currently, I have problem of the UBoot MCC driver. I setup the
internal loopback on MPC8568. And here is the data of each channel:

           Channel #                Tx Data            Rx Data
                  0                         0x01                0x9D
                  1                         0x02                0xE1
                  2                         0x03                0x9E
                  3                         0x04                0xF1
                  4                         0x05                0x83
           ...

Any idea on this issue? Or where can I find a working MCC Uboot driver
of MPC8568?

Thanks for your help,

Mike
