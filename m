Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDECE679F7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 20:20:21 +1100 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id 532946B782
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 10:20:07 +0100 (CET)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 046A46B460
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 10:20:05 +0100 (CET)
Message-ID: <43FADB46.6030109@dgt.com.pl>
Date: Tue, 21 Feb 2006 10:20:06 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Uart on cpm2_io (was: Using modem signal in cpm2 uart for MPC8270)
References: <200602210954.51248.mathieu.deschamps@com2gether.net>
In-Reply-To: <200602210954.51248.mathieu.deschamps@com2gether.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2006-02-21 09:58, Użytkownik Mathieu Deschamps napisał:
> Hello,
>
> Sorry to come with this UART issue again but I had no answer and no
> better idea but asking people who knows 82xx uart well, people who 
> designed it. 
>
> My issue about this uart could be approched elseway : why is there a 
> modem_control conditionnal compilation option when PQ2 SCCs 
> (in normal operation mode which is default) take care of CTS,CD signals
> (Chap 20-8 GSMR_L register DIAG MPC8280 PQ2 Ref. Manual ) ?
>
> I fell like that is clearly a design-time choice matter that I need to 
> clarify.
>
> And simply : 
> Is this version is known to be broken when activating this option ? 
>   
Do not know what this option is, probably for disabling code from 
another driver.
With latest CVS version from denx.de you have only to enable CTS/RTS.. 
signals in menuconfig.
(And read my prior post if you're using SCC4 with SCC_CONSOLE)
