Message-Id: <5.1.0.14.2.20030225202432.0377ac88@mail.ebshome.net>
Date: Tue, 25 Feb 2003 20:25:33 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Kernel Preemption patch
In-Reply-To: <20030225211843.B11988@home.com>
References: <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net>
 <995FF289C9D69747A09E42992644595405B23686@penguin.adic.com>
 <5.1.0.14.2.20030224135756.0465b778@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:18 PM 2/25/2003, Matt Porter wrote:

>I placed Eugene's patch at ftp://source.mvista.com/pub/linuxppc/

This patch is against 2.4.19 PPC devel kernel (bk cset 1.1091.1.23, 3rd of
August 2002).
It contains the following:

1) preempt kernel (preempt-kernel-rml-2.4.19-rc5-3.patch + MV fixes)
2) lock-break (lock-break-rml-2.4.18-1.patch)
3) rtsched (rtsched-2.4.16-1.0.patch + my fixes)
4) LTT (linux trace toolkit) (0.9.5a release)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
