Return-Path: <mail4mz@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id D6DB2DE099
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 04:29:43 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so1485796wri.3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 11:29:41 -0700 (PDT)
Message-ID: <5c9cd53b0804151129l6b016daeuf41ebbd29b9c5f6b@mail.gmail.com>
Date: Tue, 15 Apr 2008 14:29:40 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MCC problem of MPC8568
In-Reply-To: <5c9cd53b0804151129s2006af68n79975e8a8c07177b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0804151129s2006af68n79975e8a8c07177b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
