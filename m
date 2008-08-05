Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6AD2ADDF02
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:43:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use
	immr alias if it exists.
Date: Tue, 5 Aug 2008 22:43:23 +0200
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
In-Reply-To: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808052243.24001.arnd@arndb.de>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 August 2008, John Rigby wrote:
> This will allow the eventual removal of device_type = "soc"
> properties in soc nodes.

Stupid question, but why not remove immrbase instead?

It seems that all users can be converted to use a reg
property of some actual device instead of making assumptions
about the register layout of the whole SOC.

	Arnd <><
