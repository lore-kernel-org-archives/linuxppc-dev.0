Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38ABCDE009
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:44:34 +1100 (EST)
Date: Fri, 18 Jan 2008 20:40:30 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFCv2] [POWERPC] Add support for freescale watchdog to
	CPM serial driver.
Message-ID: <20080118204030.48fbb683@lxorguk.ukuu.org.uk>
In-Reply-To: <4790F44F.8020009@scram.de>
References: <478F4AE3.5090803@scram.de>
	<20080118183905.2d5d8474@lxorguk.ukuu.org.uk>
	<4790F44F.8020009@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 18 Jan 2008 19:47:43 +0100
Jochen Friedrich <jochen@scram.de> wrote:

> Hi Alan,
> 
> >> If a freescale watchdog device node is present, reset the watchdog
> >> while waiting for serial input.
> > 
> > Why ? We normally rely on user space for watchdog management as only the
> > fact user space is behaving really proves a box is happy ?
> 
> This is in the boot wrapper code, not in the linux kernel.

Ok now that makes sense, thanks
