Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 81F1D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 04:05:52 +1100 (EST)
Message-ID: <421B666B.205@mvista.com>
Date: Tue, 22 Feb 2005 10:05:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Suresh Chandra Mannava <msuresh@gamebox.net>
References: <4219A711.80204@gamebox.net>
In-Reply-To: <4219A711.80204@gamebox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: kernel with marvell 64360 support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Suresh Chandra Mannava wrote:

> Hi,
>
> We designed a power-pc 7410 board with galileo mv64360 bridge.
> We are interested in porting linux on to that board.
>
> Where can I  download the linux kernel with 64360 (serial, ethernet, 
> PCI etc)
> drivers.
> please provide the pointers for the same.


You can get the latest code minus 3 patches and the enet driver from the 
latest linux-2.5 tree on bkbits.net/kernel.org. The 3 patches are in the 
linuxppc-embedded mail archive.  AFAIK, the enet driver is queued to go 
into the mainline tree but I don't know when that'll happen.  If you 
need it now, you can contact Dale Farnsworth <dfarnsworth@mvista.com>.

Mark
