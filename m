Return-Path: <ruchika.k@servergy.com>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE87C2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 16:55:40 +1100 (EST)
Received: by mail-oa0-f44.google.com with SMTP id g12so1659695oah.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 21:55:37 -0800 (PST)
Received: from [10.0.0.12] (pool-71-244-62-208.dllstx.fios.verizon.net.
 [71.244.62.208])
 by mx.google.com with ESMTPSA id lg8sm8445676obc.14.2014.02.19.21.55.36
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 19 Feb 2014 21:55:36 -0800 (PST)
Message-ID: <530598D7.5080602@servergy.com>
Date: Wed, 19 Feb 2014 23:55:35 -0600
From: Ruchika <ruchika.k@servergy.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Question about EHCI on P4080
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I've been trying to understand why the uboot code is unable to work with 
USB1.1 devices.
On a USB analyzer:
I notice on an analyzer that there are no SOF or IN tokens seen on the 
bus at all. The only  after the very first setup packet is sent and ACK'd.

The board has a hub chip on it connected to the USB controller via a 
Ulpi interface.

Uboot debug indicates that the transfer times out and was still "Active"

The kernel code indicates that a companion driver handles 1.1 devices. 
Does this mean there are 2 HCD's, one for HS and one for FS/LS in the 
kernel ?
Thank you


ruchika
