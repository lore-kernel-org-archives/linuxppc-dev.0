Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCDFCDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 11:20:02 +1100 (EST)
In-Reply-To: <12021668462559-git-send-email-afleming@freescale.com>
References: <12021668462559-git-send-email-afleming@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DB08EDC2-85D1-464B-A986-7BFC570833DF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Add oprofile support for e300
Date: Mon, 4 Feb 2008 18:19:36 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2008, at 17:14, Andy Fleming wrote:

> The e300 c3 and c4 variants support hardware performance monitor  
> counters which
> are identical to those found in the e500.

Please ignore.  I will send a new version that includes all the  
changes I apparently missed a change I had already committed.

I will send a new version of both oprofile patches so as to make the  
first patch easier to read, too.
