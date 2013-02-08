Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 445FD2C007E
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2013 03:50:42 +1100 (EST)
Date: Fri, 8 Feb 2013 17:41:24 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: fec_mpc52xx: Read MAC address from device-tree
Message-ID: <20130208174124.659775b9@crub>
In-Reply-To: <1360339952-8724-1-git-send-email-sr@denx.de>
References: <1360339952-8724-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stefan,

On Fri,  8 Feb 2013 17:12:32 +0100
Stefan Roese <sr@denx.de> wrote:

> Until now, the MPC5200 FEC ethernet driver relied upon the bootloader
> (U-Boot) to write the MAC address into the ethernet controller
> registers. The Linux driver should not rely on such a thing. So
> lets read the MAC address from the DT as it should be done here.

Somehow the patch didn't reach the netdev list. Could you please resend?

Thanks,
Anatolij
