Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED722679F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 16:39:55 +1000 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id C9CF95795F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 08:39:46 +0200 (CEST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 9705B57731
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 08:39:46 +0200 (CEST)
Message-ID: <429FFB53.2040106@dgt.com.pl>
Date: Fri, 03 Jun 2005 08:40:19 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: undisclosed-recipients: ;
References: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>
In-Reply-To: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: Getting ownership for various boards/platforms configs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2005-06-03 01:19, Użytkownik Kumar Gala napisał:

> One issue that comes up from time to time is knowing who to contact 
> about some of the various boards that are supported for PPC. I've 
> suggested in the past that we create a MAINTAINERS file in 
> arch/ppc/platforms. I've started with a list of all the _defconfigs 
> that we have and would like to see if we can get contacts for the 
> boards. All this list is meant to be is a contact point.
>
>
There is another issue..

May I suggest to add one full-custom board?
There are a lot of changes to do inside uart,fec,fcc drivers with a lot
of #ifdefs,
just because different use of mpc resources on different boards.
Why it's not configured via menuconfig?
Another nice example is inside status_led.h...
