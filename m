Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCF16DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 18:25:51 +1000 (EST)
To: Vitaly Bordug <vitb@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: Where did the =?UTF-8?Q?fs=5Fenet=20patches=20go=3F?=
MIME-Version: 1.0
Date: Wed, 19 Sep 2007 10:25:40 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
In-Reply-To: <20070919114035.075acafb@localhost.localdomain>
References: <20070919114035.075acafb@localhost.localdomain>
Message-ID: <8406613ce51e309ebffa430dcec8bbf6@127.0.0.1>
Content-Type: text/plain; charset="UTF-8"
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 19 Sep 2007 11:40:35 +0400, Vitaly Bordug <vitb@kernel.crashing.org> wrote:
> On Wed, 19 Sep 2007 09:05:16 +0200
>> Where did the patches containing the reworked fs_enet drivers and the
>> generic bitbanged MDIO library go?
>> I am talking about these 8 patches:
>> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg03184.html
>>
>> They seem to have been removed from
>> http://patchwork.ozlabs.org/linuxppc/ ...
>>
>> AFAICS, they have not been merged in neither galak or paulus git.
>>
>> It works nicely here at my mpc8270 target btw. :-)
>>
> iirc they are slowly spinning with netdev/Jeff Garzik... Scott would know
> for sure :)

Ah, I see. Thanks.

Most of it is at least ack'ed by Jeff. But he did not seem to like
the generic bitbanged MDIO library.
Scott, what is the plan with that part?  I need it :-)

/Esben
-- 
Esben Haabendal
Embedded Software Consultant
Doré Development ApS
