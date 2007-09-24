Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F0833DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 20:34:25 +1000 (EST)
Message-ID: <46F7926F.5060902@ru.mvista.com>
Date: Mon, 24 Sep 2007 14:33:19 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 0/3] usb: ehci ppc device-tree-aware driver
References: <20070917125039.GA29525@ru.mvista.com> <fd46qj$s6r$1@sea.gmane.org>
In-Reply-To: <fd46qj$s6r$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> On Mon, 17 Sep 2007 16:50:39 +0400, Valentine Barshak wrote:
> 
>> Some PowerPC systems have a built-in EHCI controller.
>> This is a device tree aware version of the EHCI controller driver.
>> Currently it's been tested on the PowerPC 440EPx Sequoia board.
>> Other platforms can be added later.
>> The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
> 
> We're having a strange issue on our Sequoia where the network stops
> functioning when USB is active. Jerone can supply more detail...

OK.
This possibly could be caused by the plb write pipelining errata.
Please, take a look at:
http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042999.html

> 
> Have you seen anything like that?

No, I haven't.

> 

Thanks,
Valentine.
