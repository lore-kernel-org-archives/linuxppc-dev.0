Return-Path: <super.firetwister@googlemail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 9AD5DDE08A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 02:05:28 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1655267pyi.27
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Sep 2008 09:05:26 -0700 (PDT)
Message-ID: <6a6049b80809030905u561043ecr1438d20aebf5598d@mail.gmail.com>
Date: Wed, 3 Sep 2008 18:05:26 +0200
From: "M B" <super.firetwister@googlemail.com>
To: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: irq
In-Reply-To: <319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <319b0ac50809030715h1a03a606jacddd400019f4483@mail.gmail.com>
	<48BEA106.9090307@selcomgroup.com>
	<319b0ac50809030803p6d659468wd7d2425224653374@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this seems to be the same problem I had, when registering an irq with UIO.

On Wed, Sep 3, 2008 at 5:03 PM, S=E9bastien Chr=E9tien
<sebastien.chretien.enseirb@gmail.com> wrote:
> The failure referes to setup_irq :
> desc->chip =3D=3D &no_irq_chip is true
>
> What is irq_desc and how can I initialize it ?

I did use irq_create_mapping, to initialize this struct. However I
have no idea if this was right. It seemed to work at first, but I'm
encountering problems now, however I don't know if they come from the
kernel, or UIO interrupt handler. I did this for some test, but irqs
are something you want to be sure they work correctly.

So maybee someone could clarify this as we already raise this issue.

What processor are you using Sebastien? My one is a 405EP

Best Regards

Markus
