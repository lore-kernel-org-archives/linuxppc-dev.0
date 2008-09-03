Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F37F0DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 07:03:16 +1000 (EST)
Message-ID: <48BEFB5D.3040903@gmail.com>
Date: Wed, 03 Sep 2008 23:02:21 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: irq
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
	<48BEBD17.1030705@gmail.com>
	<20080903170815.GA10979@loki.buserror.net>
In-Reply-To: <20080903170815.GA10979@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: M B <super.firetwister@googlemail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

irq_of_parse_and_map is equivalent to ioremap in the MMU case ?

Scott Wood a écrit :
> On Wed, Sep 03, 2008 at 06:36:39PM +0200, Sébastien Chrétien wrote:
>   
>> Ok I will try irq_create_mapping tomorrow.
>> When have I to use this function ?
>>     
>
> You always need to create a mapping (though doing it with
> irq_of_parse_and_map is preferred).  request_irq() takes virtual IRQ
> numbers, not hardware IRQ numbers.
>
> -Scott
>
>   
