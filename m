Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E80D2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 00:31:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [PATCH 1/2][v2] driver/memory:Move Freescale IFC driver to a
 common driver
Date: Wed, 15 Jan 2014 14:31:35 +0100
References: <1389788003-25442-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1389788003-25442-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201401151431.35731.arnd@arndb.de>
Cc: scottwood@freescale.com, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 15 January 2014, Prabhakar Kushwaha wrote:
> Freescale IFC controller has been used for mpc8xxx. It will be used
> for ARM-based SoC as well. This patch moves the driver to driver/memory
> and fix the header file includes.
> 
> Also remove module_platform_driver() and  instead call
> platform_driver_register() from subsys_initcall() to make sure this module
> has been loaded before MTD partition parsing starts.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

provided that you also move the binding from powerpc/fsl/ifc.txt to
memory/fsl-ifc.txt.
