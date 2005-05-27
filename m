Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6457967B31
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 17:00:24 +1000 (EST)
In-Reply-To: <429639D5.20609@chello.nl>
References: <429639D5.20609@chello.nl>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6CEFEB5-1F03-45DA-8BA3-C1F1511950EA@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Fri, 27 May 2005 08:53:22 +0200
To: Theo Gjaltema <gjalt007@chello.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Dynamic libraries do not work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Theo,

What type of processor are you using? 8xx?
Did you build a tool-chain yourself and are
you perhaps using floating point?

Jaap-Jan

On 26-mei-2005, at 23:04, Theo Gjaltema wrote:

> Hello,
>
> I have a linux 2.4.20 kernel running, but the files in the ramdisk  
> fail to execute if they are dynamically build.
> The whole system stops (debuggers shows that it crashed while in an  
> erea where no flash/ram is present.
> Anyone an idea?
> There is nog difference between the use of a ramdisk or an nfs  
> mounted root filesystem.
>
> Greetings,
>    Theo.
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

____
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
