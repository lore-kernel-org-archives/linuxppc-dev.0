Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6E5D9DDEFD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 05:46:22 +1100 (EST)
Message-ID: <4790F44F.8020009@scram.de>
Date: Fri, 18 Jan 2008 19:47:43 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to
	CPM serial driver.
References: <478F4AE3.5090803@scram.de>
	<20080118183905.2d5d8474@lxorguk.ukuu.org.uk>
In-Reply-To: <20080118183905.2d5d8474@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Alan,

>> If a freescale watchdog device node is present, reset the watchdog
>> while waiting for serial input.
> 
> Why ? We normally rely on user space for watchdog management as only the
> fact user space is behaving really proves a box is happy ?

This is in the boot wrapper code, not in the linux kernel.

Thanks,
Jochen
