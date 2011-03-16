Return-Path: <jacmet@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E64BB6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 08:25:57 +1100 (EST)
Received: by wwb28 with SMTP id 28so2128754wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 14:25:52 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH v2 21/28] powerpc: sysdev/mpc8xxx_gpio irq_data conversion.
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110308000004.GZ16649@mail.wantstofly.org>
	<20110309082658.GR16649@mail.wantstofly.org>
Date: Wed, 16 Mar 2011 22:25:48 +0100
In-Reply-To: <20110309082658.GR16649@mail.wantstofly.org> (Lennert Buytenhek's
	message of "Wed, 9 Mar 2011 09:26:58 +0100")
Message-ID: <87aagun4f7.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Lennert" == Lennert Buytenhek <buytenh@wantstofly.org> writes:

 Lennert> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
 Lennert> ---
 Lennert> v2: get_irq_chip_data(d->irq) => irq_data_get_irq_chip_data(d)

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
