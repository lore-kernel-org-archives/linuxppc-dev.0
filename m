Return-Path: <chretien@enseirb.fr>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C035ADE078
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 03:54:23 +1000 (EST)
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m8JHqSKc028445
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 19:52:28 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id c--rVSq8bvlK for <linuxppc-dev@ozlabs.org>;
	Fri, 19 Sep 2008 19:53:14 +0200 (MEST)
Received: from [172.16.8.65] (seb@chretien.mds [172.16.8.65])
	(authenticated bits=0)
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m8JHqQSO028443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 19:52:26 +0200 (MEST)
Message-ID: <48D3E6F0.7040504@enseirb.fr>
Date: Fri, 19 Sep 2008 19:52:48 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: ioremap and vmalloc
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca> <48D3D47E.5050200@gmail.com>
	<20080919163819.GB4492@yoda.jdub.homelinux.org>
	<48D3D70D.3060404@enseirb.fr>
	<20080919165833.GD4492@yoda.jdub.homelinux.org>
In-Reply-To: <20080919165833.GD4492@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The chip that I am using is a MPC7448.
The Kernel version is 2.6.26.
I am developping my own driver.
I am making some tests

Josh Boyer a écrit :
> On Fri, Sep 19, 2008 at 06:45:01PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
>   
>> if I write :
>> ioremap(0x20000000,0x40000) and ioremap(0x20000000,0x50000)
>>
>> Will it crash ?
>>     
>
> I have no idea.  You haven't given us enough information to really answer
> that.
>
> Basic information needed would be: 
>
> 1) What board/chip
> 2) What kernel version
> 3) What are you actually trying to do
> 4) What driver are you using
> 5) If you are writing your own, where is the code for it
>
> etc.
>
> josh
>
>   
