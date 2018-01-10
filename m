Return-Path: <madskateman@gmail.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH18C6TgSzF0k8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 07:39:23 +1100 (AEDT)
Received: by mail-qk0-x22b.google.com with SMTP id z12so734537qkf.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 12:39:22 -0800 (PST)
MIME-Version: 1.0
From: mad skateman <madskateman@gmail.com>
Date: Wed, 10 Jan 2018 22:39:19 +0200
Message-ID: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
Subject: DPAA Ethernet traffice troubles with Linux kernel
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi linux devs,

Like mentioned in this thread
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-January/167630.html
i also experience the exact same issues.
I am also trying to find out why the network traffic is not flowing
the way it should (out for example ).

My linux knowledge is very basic but i hope i can contribute anyway.

I am using the AmigaOne X5000 with a P5020
Most detailed technical information regarding this issue can be found
in the Thread by Jamie Krueger mentioned above.

In this screenshot, the ETH0 and ETH1 seem up and running (probed) ..
even due to the FSL_DPAA_MAC error messages that DMESG shows.
http://www.skateman.nl/wp-content/uploads/2018/01/Screenshot-at-2018-01-08-21_22_06_ETH_NIC_ERROR.png

http://www.skateman.nl/wp-content/uploads/2018/01/Screenshot-at-2018-01-08-22_16_28.png

I was able to use some tooling like ETHTOOL to adjust some settings
and check if the interface responded. This all seems fine.

Hope that someone can find a fix, so the Ethernet adapter can be used.

Thanks!!
