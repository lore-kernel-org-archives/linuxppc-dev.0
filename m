Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F52ADDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 04:24:44 +1000 (EST)
Date: Tue, 4 Sep 2007 13:24:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: disable interrput under ppc?
Message-ID: <20070904182433.GD18280@ld0162-tx32.am.freescale.net>
References: <200709041044.16525.wangbj@lzu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709041044.16525.wangbj@lzu.edu.cn>
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

On Tue, Sep 04, 2007 at 10:44:14AM +0800, Wang, Baojun wrote:
> hi, list
> 
>   How can I disable interrput like `cli' in x86?

local_irq_disable().

> I want the following code freeze the box but it doesn't, $MSR is
> altered however the box is still alive, how can I freeze the box like
> `cli' in x86? Thanks very much!

Disabling interrupts doesn't freeze the machine by itself -- it depends
on what you do afterwards, which you didn't show.

-Scott
