Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F20EDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 09:09:33 +1100 (EST)
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264924@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264924@aquib01a>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D0440845-5484-4119-BC01-8117C18611AE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: wait_for_completion blocks the whole kernel?
Date: Wed, 21 Feb 2007 16:08:34 -0600
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
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


On Feb 21, 2007, at 3:10 PM, DI BACCO ANTONIO - technolabs wrote:

> Is it possible that calling wait_for_completion the whole kernel  
> freezes?
May you are doing it with interrupts off some how?
> Is it possible to specify a timeout for wait_for_completion?
wait_for_completion_timeout

- k
