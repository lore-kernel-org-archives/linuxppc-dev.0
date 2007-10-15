Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ADA25DDF4A
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:55:05 +1000 (EST)
Message-ID: <47137F41.6000404@freescale.com>
Date: Mon, 15 Oct 2007 09:54:57 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/7] rheap: Changes config mechanism
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>	<20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>	<751956FC-6B75-416C-A62A-67915652EA51@kernel.crashing.org>	<fa686aa40710150655s37d8c7d5ye9122034f768a897@mail.gmail.com>
	<5D5FEAFA-AFB9-4F8D-941E-11686E8992F4@kernel.crashing.org>
	<47137ECD.9020103@freescale.com>
	<4540BB4B-8A7C-4D8F-9BBE-0B6F6DAD4DA3@kernel.crashing.org>
In-Reply-To: <4540BB4B-8A7C-4D8F-9BBE-0B6F6DAD4DA3@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> If you turn on the QE but don't turn on RHEAP, the build will fail.  
>> Do we want to allow that?
> 
> nope.

Is there any way to force RHEAP to be selected when it's a user-selectable option?


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
