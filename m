Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 668E26817A
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 04:44:33 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0608.wanadoo.fr (SMTP Server) with ESMTP id 1D6F71C0025D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 20:44:27 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-27-135.w82-126.abo.wanadoo.fr
	[82.126.145.135])
	by mwinf0608.wanadoo.fr (SMTP Server) with ESMTP id 047CB1C001EF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 20:44:27 +0200 (CEST)
Date: Thu, 1 Sep 2005 20:38:08 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050901183808.GA23764@localhost.localdomain>
References: <42FC77F7.708@g-house.de>
	<C46831A4-9BDC-4C28-9A30-55C414F4FAC4@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C46831A4-9BDC-4C28-9A30-55C414F4FAC4@freescale.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, Christian <evil@g-house.de>
Subject: Re: use of rtc.c on chrp/prep?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 01, 2005 at 12:57:55PM -0500, Kumar Gala wrote:
> Does anyone enable CONFIG_RTC on chrp/prep?  Tom tells me these are  
> the only platforms that it is even valid to do so on.

The debian powerpc kernels enables :

  $ grep RTC /boot/config-2.6.12-1-powerpc
  CONFIG_GEN_RTC=y
  CONFIG_GEN_RTC_X=y

and not the CONFIG_RTC variant, and it works well on pegasos, and prep boxes,
and probably on ibm chrps too, altough i have not tested personally.

Friendly,

Sven Luther
