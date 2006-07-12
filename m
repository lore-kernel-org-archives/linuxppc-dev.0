Return-Path: <jfaslist@yahoo.fr>
Received: from smtp010.mail.ukl.yahoo.com (smtp010.mail.ukl.yahoo.com
	[217.12.11.79]) by ozlabs.org (Postfix) with SMTP id 599FD67B7A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 20:45:16 +1000 (EST)
Message-ID: <44B4D2A4.7090204@yahoo.fr>
Date: Wed, 12 Jul 2006 12:44:52 +0200
From: jf simon <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Maple platform - adding graphics to IBM PIBS firmware
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>	
	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>	
	<Pine.LNX.4.60.0607102135330.10561@poirot.grange>	
	<1152567817.1576.114.camel@localhost.localdomain>	
	<44B3A772.3000101@yahoo.fr>
	<1152658938.6346.76.camel@localhost.localdomain>
In-Reply-To: <1152658938.6346.76.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
Benjamin Herrenschmidt wrote:

>
>If the BIOS hasn't initialized the chip, you are pretty much out of
>luck... The good news is that soft-booting an rv100 with the BIOS works
>fine, at least from my previous experiemnts with it.
>
>  
>
I was (naively) thinking that if I could access the legacy VGA register 
set, I could set the graphic card to text mode and use the graphic 
screen as a alphanumeric console, until linux soft boots the graphic 
card . Do you think this is doable? I haven't been able to locate that 
VGA register set yet.
Thanks,.
-jf simon


	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
