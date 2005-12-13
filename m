Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E25A688A1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 00:33:04 +1100 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id 7C1086AD37
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 14:32:55 +0100 (CET)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 196596AD35
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 14:32:55 +0100 (CET)
Message-ID: <439ECE63.2050500@dgt.com.pl>
Date: Tue, 13 Dec 2005 14:36:35 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <439E86DC.4010901@dgt.com.pl>
In-Reply-To: <439E86DC.4010901@dgt.com.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Subject: Re: HZ manipulation
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Found it!

Sorry, It was my error.

I have few #ifdef-s to determine HZ value depend on  selected board,
but in some (for example itimer.c and timer.c) files <linux/config.h> is 
NOT included
before <asm/param.h> is included sowhere in the dark....
So some code was compiled with default value
