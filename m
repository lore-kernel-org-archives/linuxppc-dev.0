Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18311DE059
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 02:35:53 +1000 (EST)
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m8JGXsea017563
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 18:33:54 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id w1IXnl-VuV8S for <linuxppc-dev@ozlabs.org>;
	Fri, 19 Sep 2008 18:34:40 +0200 (MEST)
Received: from [172.16.8.65] (seb@chretien.mds [172.16.8.65])
	(authenticated bits=0)
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m8JGXo8a017555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 18:33:50 +0200 (MEST)
Message-ID: <48D3D47E.5050200@gmail.com>
Date: Fri, 19 Sep 2008 18:34:06 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: ioremap and vmalloc
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca>
In-Reply-To: <20080919134933.GA7849@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The first is ioremap(0x20000000,0x10000000);
The second is ioremap(0x80000000,0x10000000);
Is it too long

Grant Likely a écrit :
> On Fri, Sep 19, 2008 at 01:15:20PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
>   
>> Hello,
>>
>> When I use ioremap, the second time, I obtain this message :
>>
>> allocation failed: out of vmalloc space - use vmalloc=<size> to increase
>> size.
>> What can I do in order to fix this problem ?
>>     
>
> How large are the regions that you are ioremapping?  The kernel sets
> aside a fixed amount of the virtual address space for ioremaps, and if
> you exhaust that then more ioremaps will stop working.
>
> g.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
