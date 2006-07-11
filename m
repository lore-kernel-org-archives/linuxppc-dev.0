Return-Path: <jfaslist@yahoo.fr>
Received: from smtp004.mail.ukl.yahoo.com (smtp004.mail.ukl.yahoo.com
	[217.12.11.35]) by ozlabs.org (Postfix) with SMTP id 130EE67B22
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 23:35:21 +1000 (EST)
Message-ID: <44B3A772.3000101@yahoo.fr>
Date: Tue, 11 Jul 2006 15:28:18 +0200
From: jf simon <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Maple platform - adding graphics to IBM PIBS firmware
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>	<20060710214158.1d8dcf2c@vitb.ru.mvista.com>	<Pine.LNX.4.60.0607102135330.10561@poirot.grange>
	<1152567817.1576.114.camel@localhost.localdomain>
In-Reply-To: <1152567817.1576.114.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
We have designed a VME CPU card based on IBM Maple platform.
We've had problems making it work with a PCI/PMC graphic card we've also 
designed based around the ATI Radeon 7000 (RV100 QY). To solve this we 
have linux consultants helping us in emulating the ATI video BIOS at the 
linux kernel level.
But we would like to modify  the PIBs firmware with simple routines 
(scroll,..)  to use the graphic screen attached to the ATI as a text 
(alphanumeric) console. The keyboard would be USB.
Is this possible even if the video BIOs didn't previously  initialize 
the ATI graphic chip?
I realize this question doesn't really belong here...but not sure where 
to ask, sorry about that.
Thanks a lot
-jf simon






	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
