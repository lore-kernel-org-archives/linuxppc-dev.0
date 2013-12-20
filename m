Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E704A2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 08:17:04 +1100 (EST)
Date: Fri, 20 Dec 2013 22:16:56 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH v2] powerpc/512x: dts: disable MPC5125 usb module
Message-ID: <20131220221656.70e151f7@crub>
In-Reply-To: <1387530982-6115-1-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1387530982-6115-1-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gsi@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Dec 2013 10:16:22 +0100
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:

> At the moment the USB controller's pin muxing is not setup
> correctly and causes a kernel panic upon system startup, so
> disable the USB1 device tree node in the MPC5125 tower board
> dts file.
> 
> The USB controller is connected to an USB3320 ULPI transceiver
> and the device tree should receive an update to reflect correct
> dependencies and required initialization data before the USB1
> node can get re-enabled.
> 
> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> ---
> v2:
> * improve the text of the commit as suggested by Gerhard Sittig <gsi@denx.de>
> * put the 'status = "disabled"' to the last line in the list of properties
> * rewiew the comment related to USB1 device tree node
> ---
>  arch/powerpc/boot/dts/mpc5125twr.dts | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to merge branch. Thanks!

Anatolij
