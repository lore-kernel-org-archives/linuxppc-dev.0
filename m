Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB095DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Aug 2007 06:53:22 +1000 (EST)
Message-ID: <46B395B5.1040009@freescale.com>
Date: Fri, 03 Aug 2007 15:53:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: BusyBox passwd requires root privileges
References: <11990563.post@talk.nabble.com>
In-Reply-To: <11990563.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

khollan wrote:
> I log on as a user and I want to use passwd to change that users password but
> it gives me the 
> passwd: applet requires root privileges!
> I can login as root and change all user passwords, but I want individual
> owners to be able to update their passwords.  Any ideas?

passwd needs to be setuid root.

-Scott
