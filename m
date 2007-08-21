Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 23AC9DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 22:52:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so1458489wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 05:52:12 -0700 (PDT)
Message-ID: <fa686aa40708210552n129cc927jbeb3641690421420@mail.gmail.com>
Date: Tue, 21 Aug 2007 06:52:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Computer - Service" <computer-service@gmx.de>
Subject: Re: Linux 2.6.23.rc3 boot issues on XUPV2P
In-Reply-To: <46CAD865.3030107@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46CAC89F.2040100@genesi-usa.com> <46CACAAE.5000304@genesi-usa.com>
	<20070821113232.GB1111@localhost.localdomain>
	<46CAD865.3030107@gmx.de>
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

On 8/21/07, Computer - Service <computer-service@gmx.de> wrote:
> Hi all.
>
> I try to port Linux 2.6 on my XUPV2P Board which is based on ML300.
>
> It runs sometimes, but for the usual case it just doesn't.
> My problem is the initialization.
> I have no clue why I get different values almost every time.
> This is a log from the same zImage.elf, which is just loaded certain
> times in the row:

Check that the Virtex support code in
arch/ppc/boot/simple/embed_config.c is getting compiled in (hint:
search for ML403).  If it's configured out, then your board info
structure won't get setup correctly.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
