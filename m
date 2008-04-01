Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 80F7EDE30A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 02:31:11 +1100 (EST)
Message-ID: <47F25518.8070408@freescale.com>
Date: Tue, 01 Apr 2008 10:30:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Commits added to powerpc.git master/powerpc-next branches
References: <18418.5519.903340.966932@cargo.ozlabs.ibm.com>
In-Reply-To: <18418.5519.903340.966932@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> I have updated the master and powerpc-next branches of the powerpc.git
> repository with the following commits, including some pulled from Josh
> Boyer and Kumar Gala.

How about this patch?

	Enable CONFIG_FORCE_MAX_ZONEORDER for all PowerPC, and make selectable


-- 
Timur Tabi
Linux kernel developer at Freescale
