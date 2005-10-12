Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 70FFF68515
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 06:47:44 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i13so97343wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 13:47:42 -0700 (PDT)
Message-ID: <c3d0340b0510121340w4cb5cd2eg5cfdef86cd1528cf@mail.gmail.com>
Date: Wed, 12 Oct 2005 13:40:26 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Nathael PAJANI <nathael.pajani@cpe.fr>
In-Reply-To: <434CDF76.3080705@cpe.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <434CDF76.3080705@cpe.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: init process not running
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What about your UART driver and interrupt controller? I had such
experience before and it turned out to be a problem in interrupt
controller driver. The serial driver uses interrupt mode to operate
UART once init gets called.

Just my 2 cents.

-Shawn.
