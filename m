Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38781DE3A5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 02:37:26 +1000 (EST)
Message-ID: <48BEBD17.1030705@gmail.com>
Date: Wed, 03 Sep 2008 18:36:39 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
MIME-Version: 1.0
To: M B <super.firetwister@googlemail.com>
Subject: Re: irq
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>	
	<48BEA106.9090307@selcomgroup.com>	
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
	<6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
In-Reply-To: <6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok I will try irq_create_mapping tomorrow.
When have I to use this function ?
I am using a MPC7448.

M B a écrit :
> Hi,
>
> this seems to be the same problem I had, when registering an irq with UIO.
>
> On Wed, Sep 3, 2008 at 5:03 PM, Sébastien Chrétien
> <sebastien.chretien.enseirb@gmail.com> wrote:
>   
>> The failure referes to setup_irq :
>> desc->chip == &no_irq_chip is true
>>
>> What is irq_desc and how can I initialize it ?
>>     
>
> I did use irq_create_mapping, to initialize this struct. However I
> have no idea if this was right. It seemed to work at first, but I'm
> encountering problems now, however I don't know if they come from the
> kernel, or UIO interrupt handler. I did this for some test, but irqs
> are something you want to be sure they work correctly.
>
> So maybee someone could clarify this as we already raise this issue.
>
> What processor are you using Sebastien? My one is a 405EP
>
> Best Regards
>
> Markus
>
>
>   
