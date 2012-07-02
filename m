Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 263B62C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 04:19:26 +1000 (EST)
Message-ID: <4FF1E625.9040403@freescale.com>
Date: Mon, 2 Jul 2012 13:19:17 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
 <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
 <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
 <DF5BDBFF-A726-4E1C-832E-EF2629F60DC9@kernel.crashing.org>
 <0154F680-D9F4-4CE1-BF5E-11884AD0ED4A@freescale.com>
 <AC087E7A-B7BC-43E5-948F-68AEB8251FD3@kernel.crashing.org>
 <4F63652C.3050108@freescale.com>
 <9508ABD9-607F-4D41-A169-743ADE625F4A@kernel.crashing.org>
In-Reply-To: <9508ABD9-607F-4D41-A169-743ADE625F4A@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kokoris,
 Ioannis" <ioannis.kokoris@siemens-enterprise.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> > No, I forgot all about it.  I'll try it today, assuming the lone 8323
>> > board in the board farm still works.

> Do you remember if you ever tested this?

Well, I tried to test it.  We have an 83xx board that has a QE UART that
needs firmware uploaded, but I don't know how to connect that QE to an
actual RS232 port.  It needs a riser which I don't think we have.

I can verify that the QE UART driver does not hang which this patch, and
that it appears to still be sending data, but I have no way of knowing for
sure.

-- 
Timur Tabi
Linux kernel developer at Freescale
