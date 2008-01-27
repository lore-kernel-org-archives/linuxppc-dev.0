Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D0D89DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 10:27:12 +1100 (EST)
Date: Sun, 27 Jan 2008 17:39:23 -0600
From: Olof Johansson <olof@lixom.net>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Reminder: removal of arch/ppc - (Sequoia)
Message-ID: <20080127233923.GA5550@lixom.net>
References: <20080127231214.1F50ADDDE9@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080127231214.1F50ADDDE9@ozlabs.org>
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

Hi,

On Sun, Jan 27, 2008 at 06:05:06PM -0500, Steve Heflin wrote:
> The Sequoia board (AMCC-440EPx processor) is missing from the new 
> arch/powerpc. The Sequoia board is also missing from arch/ppc , but 
> there is support for integrated devices on the AMCC part inside 
> arch/ppc that needs to be incorporated into arch/powerpc. In 
> addition, there needs to be a "sequoia.c" file added to the 
> arch/powerpc/44x directory.  I have a good start on the missing 
> pieces and a test platform, is this contribution desired?

2.6.24 already has sequoia support in arch/powerpc. Are you looking at
an older tree?

olof@quad:~/work/linux/k.org $ head arch/powerpc/platforms/44x/sequoia.c
/*
 * Sequoia board specific routines
 *
 * Valentine Barshak <vbarshak@ru.mvista.com>
 * Copyright 2007 MontaVista Software Inc.
 *
 * Based on the Bamboo code by
 * Josh Boyer <jwboyer@linux.vnet.ibm.com>
 * Copyright 2007 IBM Corporation
 *
...
