Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20798683CF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 16:21:36 +1000 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id 23EF36A556
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 08:21:28 +0200 (CEST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id E808C6A550
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 08:21:27 +0200 (CEST)
Message-ID: <434A08AF.9070502@dgt.com.pl>
Date: Mon, 10 Oct 2005 08:22:39 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <1CFEB358338412458B21FAA0D78FE86D4F0E0D@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E0D@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: mpc8248 and FCC ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>
>so double check your manual. The MPC8555E manual is still wrong in
>this regard, and no errata has been issued yet.
>
>  
>
Uff, it works now.Thank You for quick reply.

Surely MPC8272 familly doc says there are 8K DPRAM from 0 to 0x1fff
It should be updated in include/asm/cpm_8260.h
