Return-Path: <robinpv@aiware.co.jp>
Received: from cat.aiware.co.jp (ml.aiware.jp [222.228.111.22])
	by ozlabs.org (Postfix) with ESMTP id 82FD867A64
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 16:47:27 +1000 (EST)
Received: from [192.168.25.80] (neko.aiware.jp [222.228.111.24])
	by cat.aiware.co.jp (Postfix) with ESMTP id A205EF63E6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:47:25 +0900 (JST)
Message-ID: <449B8EBC.7040606@aiware.co.jp>
Date: Fri, 23 Jun 2006 15:48:28 +0900
From: robinpv <robinpv@aiware.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Help on OHCI USB host present in SM501 chip
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi ,
I am using MPC5200 based board and i have SM501 Mobile Multimedia 
companion chip on the PCI bus.
I am writing OHCI USB host present on the SM501 chip. I wanted to know 
if driver already exists.
I searched in linux ppc,  i could find the driver for the VGA( 
controller present in SM501) but not USB.
Currently i am referring to ohci-sa1111.c as reference.

Thanks in advance
Robin
