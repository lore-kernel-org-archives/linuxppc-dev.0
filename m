Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 45B3367A05
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 02:24:34 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so375730ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 09:24:33 -0700 (PDT)
Message-ID: <82ecf08e0605120924p59ae4c21pb0fbf3e8b7170c07@mail.gmail.com>
Date: Fri, 12 May 2006 13:24:33 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Felix Domke" <tmbinc@elitedvb.net>
Subject: 2.6 vs 2.4
In-Reply-To: <44649F09.2020803@elitedvb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
	<82ecf08e0605120729l43041aebuaef375a568700354@mail.gmail.com>
	<44649F09.2020803@elitedvb.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Can you point me to a list of changes which where done? I really like to
> check if they apply to my performance problems with 2.6 kernels, i.e. if
> it's worth porting the board specific changes to a newer kernel.
>

I'm sorry, I was thinking (specifically) of the 8XX port that went
from broken to maintained.

It would help if you could mention some ofthe problems you are having.

>When we switched from 2.4 to 2.6, IDE performance ("hdparm -t" to have a
>single number) was reduced by about 25% (even after trying to finetune
>the IDE driver

>On a 300MHz embedded mips machine, saturating a 100MBit network link via
>ftp is not easy.

Unfortunatelly my knowlege of IDE is almost 0. Maybe it has something
to do with schedulers being used?

About network, I had better results with a much slower processor than
your reported 5Mb/s (60MHz PPC in 2.6.10)


Thiago
