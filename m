Return-Path: <chretien@enseirb.fr>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34977DDF5F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 03:02:12 +1000 (EST)
Message-ID: <48D3D70D.3060404@enseirb.fr>
Date: Fri, 19 Sep 2008 18:45:01 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: ioremap and vmalloc
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>	<20080919134933.GA7849@secretlab.ca>
	<48D3D47E.5050200@gmail.com>
	<20080919163819.GB4492@yoda.jdub.homelinux.org>
In-Reply-To: <20080919163819.GB4492@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

if I write :
ioremap(0x20000000,0x40000) and ioremap(0x20000000,0x50000)

Will it crash ?

Josh Boyer a écrit :
> On Fri, Sep 19, 2008 at 06:34:06PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
>   
>> The first is ioremap(0x20000000,0x10000000);
>> The second is ioremap(0x80000000,0x10000000);
>> Is it too long
>>     
>
> The error message you are getting should have been a very strong hint that
> the answer is "yes."
>
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
