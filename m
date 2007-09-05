Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED608DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 02:32:10 +1000 (EST)
Date: Wed, 5 Sep 2007 11:31:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: disable interrput under ppc?
Message-ID: <20070905163151.GA26107@ld0162-tx32.am.freescale.net>
References: <200709041044.16525.wangbj@lzu.edu.cn>
	<20070904182433.GD18280@ld0162-tx32.am.freescale.net>
	<388931546.05165@lzu.edu.cn> <200709051000.46281.wangbj@lzu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709051000.46281.wangbj@lzu.edu.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 10:00:46AM +0800, Wang, Baojun wrote:
> hw_enable_irq() and hw_disable_irq() is exactly the same as 
> local_irq_enable()/local_irq_disable(), but the output shows while running 
> hw_eable_irq() (at that point irq is disabled), the rest of the code is 
> blocked, and I don't know why:
> 
> output:
> [  172.049381] sync_root_events: looping!
> [  172.053159] sync_root_events: looping 2!
> [  172.057094] sync_root_events: looping 3!
> [  172.061027] hw_irq_disabled?: 1
> [  172.997338] sync_root_events: looping!
> [  173.001095] sync_root_events: looping 2!
> [  173.005028] sync_root_events: looping 3!
> [  173.008961] hw_irq_disabled?: 1

What did you expect the output to be?  I assume that you're taking an
interrupt after you enable interrupts?

-Scott
