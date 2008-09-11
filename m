Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1DAA7DDF7D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 21:46:38 +1000 (EST)
Message-ID: <48C90516.8040504@ru.mvista.com>
Date: Thu, 11 Sep 2008 15:46:30 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: IDE
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>	
	<319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>	
	<48C79BDE.6030905@ru.mvista.com>
	<200809101304.51990.arnd@arndb.de>	
	<48C7CC0F.9020003@ru.mvista.com> <48C8B5F3.7050409@gmail.com>
	<319b0ac50809110130m71c5c640g15cc836a9e81f491@mail.gmail.com>
In-Reply-To: <319b0ac50809110130m71c5c640g15cc836a9e81f491@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
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

> I saw pata_of_platform source. And when is called pata_of_platform_probe ?

   Look at the very end of arch/powerpc/boot/dts/mpc8349emitx.dts; 
probably there are more examples in that directory...

MBR, Sergei
