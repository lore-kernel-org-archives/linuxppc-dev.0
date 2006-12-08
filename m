Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A634567BAC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Dec 2006 01:06:45 +1100 (EST)
In-Reply-To: <20061208132038.38517.qmail@web25601.mail.ukl.yahoo.com>
References: <20061208132038.38517.qmail@web25601.mail.ukl.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D4D096D4-6157-4F79-BE75-0202C8409665@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8568E-MDS board support
Date: Fri, 8 Dec 2006 08:06:37 -0600
To: emre kara <emrekara2002@yahoo.co.uk>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 7:20 AM, emre kara wrote:

> Hi folks;
> My question is espacially to freescale people.
> We have a plan to move our platform  to a new (and
> fast) freescale cpu (currently we are using MPC8540),
> and MPC8568E is an  reasonable alternative. There is
> an development board, named MPC8568E-MDS but I
> could'nt find any resource related to it.
> Here is my questions:
> 1- Is there any plan to support this board and cpu?
> When?

typically freescale has provided patches for new boards.

> 2- What is the nearest cpu and board to start
> development on MPC8568E-MDS and how much work do we
> have to spend?

the MPC8548 CDS and MPC8360 MDS are probably the best starting points.

- k
