Return-Path: <muvarov@mvista.com>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218]) by ozlabs.org (Postfix) with ESMTP id C5720B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 19:18:55 +1100 (EST)
Received: by bwz10 with SMTP id 10so1227563bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 01 Apr 2010 01:18:53 -0700 (PDT)
Message-ID: <4BB456EC.2050408@mvista.com>
Date: Thu, 01 Apr 2010 12:18:52 +0400
From: Maxim Uvarov <muvarov@mvista.com>
MIME-Version: 1.0
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: kexec for powerpc32
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
	<20100331132300.GA15951@oksana.dev.rtsoft.ru>
	<alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
In-Reply-To: <alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Maxim Uvarov <muvarov@ru.mvista.com>, horms@verge.net.au,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau wrote:
> On Wed, 31 Mar 2010 at 17:23, Anton Vorontsov wrote:
>   
>> Kernel has all needed for kexec, but kexec-tools are broken for
>> powerpc32.
>>
>> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg22498.html
>>     
>
> Oh :-\
>
>   
>> I've just asked around, and it seems that Maxim (Cc'ed) will start
>> working on reviving ppc32 support real soon.
>>     
>
> Well, in my case the powerpc32 machine is far from being a "production 
> system", but I'm glad to hear that he's working on it!
>
> Thanks for the response,
> Christian.
>   
Yes,  the plan was to push upstream all MontaVista's powerpc kexec patches.
But also some work here is required in understanding how far community 
code from our,
port, cleanup and test patches. I hope that I will get to that task in 
this month.

Best regards,
Maxim Uvarov.
