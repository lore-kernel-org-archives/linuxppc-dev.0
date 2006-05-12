Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 88033679FF
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:36:45 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so359185ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 07:36:43 -0700 (PDT)
Message-ID: <82ecf08e0605120729l43041aebuaef375a568700354@mail.gmail.com>
Date: Fri, 12 May 2006 11:29:37 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Srinivas Murthy" <codevana@gmail.com>
Subject: Re: 2.6 vs 2.4
In-Reply-To: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi,
>  Wolfgang Denk has a good listing of issues to consider betn linux 2.4 vs
> 2.6 for ppc82xx based platforms
> (http://www.denx.de/wiki/Know/Linux24vs26).
>
>  Would this recommendation still hold?

Not much. This article is almost one year old. Even though some things
do apply (like bigger footprint, etc), the kernel improved a lot on
the months that followed that article.

I've participated in a project that used a (somewhat patched) 2.6.10
kernel, with soccessful results.

Not the mention the advantages of the 2.6 kernel in general.

>The main open question is: is somebody still maintaining the 8xx kernel
>port ?

LINUX FOR POWERPC EMBEDDED PPC8XX
P:      Marcelo Tosatti
S:      Maintained

(this has been determined AFAIK in OLS 2005)
