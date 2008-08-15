Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 951C8DE3BC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 03:59:03 +1000 (EST)
Date: Fri, 15 Aug 2008 19:48:21 +0200
From: Benjamin Krill <ben@codiert.org>
To: Darcy Watkins <dwatkins@tranzeo.com>
Subject: Re: Possible init bug in ibm_newemac/core.c
Message-ID: <20080815174821.GK10829@codiert.org>
References: <1218819785.3465.190.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1218819785.3465.190.camel@localhost>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Darcy,

>The bug normally goes unnoticed until you turn on spinlock and/or
>rtmutex debuggging in the kernel config - then the debugging magic
>checks will catch it during boot.

Have a look at thread:
http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061631.html

cheers
 ben
