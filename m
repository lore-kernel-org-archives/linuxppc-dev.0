Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 732A267A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 02:56:27 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859338@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859338@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f476b44c655d9125f95b6d3ddc225576@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 5 Apr 2005 12:56:11 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 5, 2005, at 12:41 PM, Rune Torgersen wrote:

> Without calling fcc_restart in the start, I get lots of "eth0: tx queue
> full!." messages.

Do you tftp boot your kernel using the boot rom?  Does the
boot rom disable the Ethernet before calling the kernel?

Thanks.


	-- Dan
