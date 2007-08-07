Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DD78DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 04:10:36 +1000 (EST)
In-Reply-To: <20070807152644.73689DDE38@ozlabs.org>
References: <20070807152644.73689DDE38@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D7E4BC5A-FC9F-4C08-A680-05900135DC1E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Linux PPC 8555--TSec initialisation
Date: Tue, 7 Aug 2007 13:11:37 -0500
To: shashikumar@aspirecom.net
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


On Aug 7, 2007, at 1:51 AM, Shashikumar wrote:

> Hi,
>
> I am using PPC8555. I need to initialize TSEC. Can anybody help me  
> How to
> initialize TSEC on chip of ppc8555.
>
> Thanks in advance

It should be initialized by the driver in drivers/net/gianfar*

- k
