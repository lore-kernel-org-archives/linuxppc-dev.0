Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id 807FA67AA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 08:33:36 +1100 (EST)
Message-ID: <00da01c503ef$353c79b0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Dan Malek" <dan@embeddededge.com>
References: <20050126185350.20232.qmail@web53804.mail.yahoo.com>
	<BD936D78-6FCC-11D9-A0FB-003065F9B7DC@embeddededge.com>
	<00c001c503e6$64369fb0$0301a8c0@chuck2>
	<ECCFD7F0-6FDF-11D9-A0FB-003065F9B7DC@embeddededge.com>
Date: Wed, 26 Jan 2005 16:37:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Is there a DER for the MPC82xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> The BDI2000 lets you set as many hardware breakpoints
> as the processor supports.  The VECTOR CATCH is equivalent
> ...
> ...I've used VECTOR CATCH on
> 603 cores and had it trap properly before memory was initialized.
> Using VECTOR CATCH seems to have no effect on setting
> other breakpoints.

Cool.  I was basing my comment on the fact that the BDI manual
says it must have write access to 0000-1FFF

Thanks,
Mark
