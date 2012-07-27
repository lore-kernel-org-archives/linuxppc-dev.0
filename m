Return-Path: <romieu@fr.zoreil.com>
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com
 [IPv6:2001:4b98:dc0:41:216:3eff:feb0:8c92])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E64A62C0093
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 01:48:11 +1000 (EST)
Date: Fri, 27 Jul 2012 17:25:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: sandeep@freescale.com
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120727152542.GB1613@electric-eye.fr.zoreil.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sandeep@freescale.com <sandeep@freescale.com> :
[...]
> The main functions of this Framework are:
>  - provides interface to TDM clients to access TDM functionalities.
>  - provides standard interface for TDM drivers to hook with the framework.
>  - handles various data handling stuff and buffer management.
> 
> In future this Framework will be extended to provide Interface for Line control devices also. For example SLIC, E1/T1 Framers etc.
> 
> Presently the framework supports only Single Port channelised mode.
> Also the configurability options are limited which will be extended later on.
> Only kernel mode TDM clients are supported currently. Support for User mode clients will be added later.

1. You should send some kernel mode TDM clients. Without those the framework
   is pretty useless.

2. It would probably make sense to Cc: netdev and serial. There may be
   some kernel client network integration from the start.

3. Where is the userspace configuration interface ?

[...]
> Based on: git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git

$ git clone git://git.am.freescale.net/gitolite/mirrors/galak-powerpc.git
Cloning into 'galak-powerpc'...
fatal: Unable to look up git.am.freescale.net (port 9418) (No address associated with hostname)

-- 
Ueimor
