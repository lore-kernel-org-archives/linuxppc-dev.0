Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 114672C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 01:31:02 +1000 (EST)
Message-ID: <4FF5B329.9090005@freescale.com>
Date: Thu, 5 Jul 2012 10:30:49 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
 <20120704031426.GA6133@localhost.localdomain>
 <4FF3B5B6.8090400@freescale.com>
 <20120704034545.GA6196@localhost.localdomain>
 <4FF45F19.2080607@freescale.com>
 <20120705102529.GA7982@localhost.localdomain>
In-Reply-To: <20120705102529.GA7982@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zhao Chenhui wrote:
> If the guts node is missing, this code snippet will be skipped. If the guts node is existed,
> the return value of of_iomap(), namely guts, will be tested. If it is NULL, it shows
> that there is error in dts, or the ioremap() in of_iomap() failed. I think
> these errors are fatal errors, so I print an error info and return.

Ok, I see your point now.  I'm concerned about what might happen if
someone else updates mpc85xx_smp_init() in the future, but there's nothing
actually wrong with your patch today.

-- 
Timur Tabi
Linux kernel developer at Freescale
