Return-Path: <B08782@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8ED42C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 23:47:13 +1000 (EST)
Message-ID: <524EC68B.3090402@freescale.com>
Date: Fri, 4 Oct 2013 16:45:47 +0300
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thomas_H=FChn?= <Thomas.Huehn@dai-labor.de>
Subject: Re: Gianfar driver crashes in Kernel v3.10
References: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
In-Reply-To: <8EF35D6A-A132-458C-A3B4-80D4D2C5BA4C@dai-labor.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/4/2013 3:03 PM, Thomas H=FChn wrote:
> Hi all,
>
> We are several Openwrt users based on the TPlink 4900 device and suffer=
 from a crashing gianfar driver.
> We troubleshooted the problem down to the fact, that a 3.8er Linux kern=
el is working, and a v3.10 crashes, but there is
> no reproducable case yet.

I'll have some low traffic tests with the upstream 3.10 kernel on a
p1010rdb, but since you say there's no "reproducibility case" the crash
may not be easy to spot on my side.  I wouldn't jump to conclusions
too fast, the fact that it manifests now doesn't neccesarily mean
that a bug was introduced between v3.8 and v3.10.
I'll let you know should I find something.  Meanwhile, if you have
additional information about how to reproduce it, please share.

Thanks,
Claudiu
