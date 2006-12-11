Return-Path: <info@schihei.de>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B30B67B6F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 00:01:37 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kBBD1P4u064978
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 13:01:28 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBBD1Ptp2519062
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 13:01:25 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBBD1ONc020820
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 13:01:25 GMT
In-Reply-To: <200612111111.10740.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<200612091244.05862.arnd@arndb.de>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<200612111111.10740.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D4D63351-AFCC-4E4B-AA3C-4F097DB23A13@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 14:01:33 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Dec 11, 2006, at 11:11 AM, Arnd Bergmann wrote:

> I'd like to see (2), because that's what the driver currently expects.
> The common ipmi code in linux _always_ does this calculation  
> anyway, and
> (1) only means we have to compute the reg-spacing and reg-size from  
> the
> layout of the registers, which gets rather complicated if you have  
> more
> than two of them in the reg property.

Yes, that is correct, but what happens if you have three registers  
and because of stupid reasons the reg-spacing and reg-size is different.

In (1) you can handle it without problems, in (2) not. Also, where is  
the difference if you have to calculate the reg-spacing, etc. (1) or  
the addresses (2). The effort is more or less exactly the same.

Regards,
	Heiko
