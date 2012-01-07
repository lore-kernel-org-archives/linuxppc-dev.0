Return-Path: <n-a-zhubr@yandex.ru>
Received: from forward5.mail.yandex.net (forward5.mail.yandex.net
 [IPv6:2a02:6b8:0:602::5])
 by ozlabs.org (Postfix) with ESMTP id D59B0B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2012 04:31:46 +1100 (EST)
Message-ID: <4F088122.4080505@yandex.ru>
Date: Sat, 07 Jan 2012 21:30:10 +0400
From: Nikolai Zhubr <n-a-zhubr@yandex.ru>
MIME-Version: 1.0
To: linux-usb@vger.kernel.org, openwrt-devel@lists.openwrt.org,
 linuxppc-dev@lists.ozlabs.org, support@amlogic.com
Subject: Driver(s) for Synopsys' DesignWare USB OTG
Content-Type: text/plain; charset=KOI8-R; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello developers,

I'm trying to find/combine/fix a driver for Synopsys' DesignWare USB 
controller. This thing is USB 2.0 host/slave/otg capable and is used in 
various SoCs including Amlogic 8726M, Ralink RT305x, and probably more.

There is some code floating around, partly usable, but all I could see 
for now is really not perfect. I also saw commit logs on linuxppc-dev, 
but failed to find out what repository they are related to. I'd like to 
know if someone is currently developing/testing/maintaining the driver 
or is planning to do so in the near future (in a FOSS-friendly manner - 
making development results public immediately and with eventual goal of 
inclusion into mainline) in order to avoid duplicate/uncoordinated work 
and waste of effort.

I'm currently examining 2 versions (That is, 2 sets of files):

1. From android kernel for 8726m-based tablets (like the one I own). 
Usable to some extent, but there are issues (e.g. it looks like certain 
packets get corrupted, reproducibly, relevant dumps are available)

2. From openwrt kernel for RT305x-based routers. The code looks a bit 
more tidy, but not quite well updated (slave-mode parts are unused in 
openwrt and they can not even be compiled for modern kernels without 
certain patching; have not tried host-mode on the hardware yet)

Quite obviously both versions originated from the same code initially, 
but subsequently were apparently tested/corrected/updated by separate 
teams. It is not quite clear if all bugfixes were cross-applied 
carefully (if at all). I was initially hoping that compare and bisect 
will just do the job, but the driver is quite huge... and some files 
have diverged substantially in the 2 versions, so at the moment I'm a 
bit fed up and will probably resume a bit later. Meanwhile, I'd be happy 
to discuss the subject with whoever interested in order to plan my 
further steps.

Please CC me, I'm not subscribed to the lists.

Thank you.
Nikolai.
