Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C0389DDFAC
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 20:05:24 +1000 (EST)
Message-ID: <48C79BDE.6030905@ru.mvista.com>
Date: Wed, 10 Sep 2008 14:05:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: IDE
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>	
	<48C7942C.9020304@ru.mvista.com>
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
In-Reply-To: <319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
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

Hello.

Sébastien Chrétien wrote:

> Have I to rewrite a IDE driver ?

   Most probably you can use the existing platform drivers: 
drivers/ide/egacy/ide_platform.c or drivers/ata/pata_platform.c.
Create/register a platform device named "pata_platform" with 2 memory 
and 1 IRQ resource, and enable one of those drivers.

> 2008/9/10, Sergei Shtylyov <sshtylyov@ru.mvista.com 
> <mailto:sshtylyov@ru.mvista.com>>:
>
>     Hello.
>
>     Sébastien Chrétien wrote:
>
>         I would like to setup my IDE controller. It uses a generic
>         mapping. And he is located at the adress 0x20003000.
>
>
>      What kin of controller, and what do you mean by generic mapping?
>
>         How can I specifie this adress to the ide driver ?
>
>
>      The usual ways is via the platform device.
>
>

MBR, Sergei
