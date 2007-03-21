Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E076FDE05C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 03:20:46 +1100 (EST)
Message-ID: <46015B2F.80807@ru.mvista.com>
Date: Wed, 21 Mar 2007 19:19:59 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] PPC440EPx/440GRx Sequoia/Rainier board support.
References: <20070321154317.924703535D3@atlas.denx.de>
In-Reply-To: <20070321154317.924703535D3@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wolfgang Denk wrote:
> Valentine,
>
> in message <4601461E.9010006@ru.mvista.com> you wrote:
>   
>> Add AMCC PPC440EPx/440GRx Sequoia/Rainier board support.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>     
>
> Umm...
>
>   
>> --- linux.orig/arch/ppc/platforms/4xx/ppc440epx.c	1970-01-01 03:00:00.000000000 +0300
>> +++ linux/arch/ppc/platforms/4xx/ppc440epx.c	2007-03-20 14:43:37.000000000 +0300
>> @@ -0,0 +1,284 @@
>> +/*
>> + * arch/ppc/platforms/4xx/ppc440epx.c
>> + *
>> + * PPC440EPx I/O descriptions
>> + *
>> + * Wade Farnsworth <wfarnsworth@mvista.com>
>> + * Copyright 2004-2007 MontaVista Software Inc.
>> + * Copyright 2006 AMCC
>>     
>
> The same file in our repository looks like this:
>
> /*
>  * arch/ppc/platforms/4xx/ppc440epx.c
>  *
>  * PPC440EPx I/O descriptions
>  *
>  * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
>  *
>  * Wade Farnsworth <wfarnsworth@mvista.com>
>  * Copyright 2004 MontaVista Software Inc.
>  * Copyright 2006 AMCC
>
>
> In other words: You *removed* Stefan Roese's (resp.  DENX)  Copyright
> entry, and replaced it by one for MV?
>
>
> I think this was not done by accident.
>
> I don't know what to say.
>
>
> I think your patches should be rejected.
>
>
> Wolfgang Denk
>
>   

I'm sorry, but I did *not* remove any copyrights. I've got this file 
from AMCC with *no* DENX Software copyright.
Please take a look at this link: 
http://www.amcc.com/Embedded/Downloads/download.html?item=365
You might have a later version in your repository.
Thanks.
