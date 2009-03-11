Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 54189DE28B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:53:36 +1100 (EST)
Date: Wed, 11 Mar 2009 16:53:34 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <alpine.LFD.2.00.0903110835020.32478@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0903111652070.1040@vixen.sonytel.be>
References: <1236729444.7086.24.camel@pasglop>
	<alpine.LRH.2.00.0903111028480.1040@vixen.sonytel.be>
	<1236769025.7086.46.camel@pasglop>
	<alpine.LFD.2.00.0903110835020.32478@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Linus,

On Wed, 11 Mar 2009, Linus Torvalds wrote:
> On Wed, 11 Mar 2009, Benjamin Herrenschmidt wrote:
> > I'd like to have Andrew or Linus opinion on doing this driver swap that
> > late in the process.
> 
> Quite franklly, no. 
> 
> If it was a totally _new_ driver, there's no chance of regression, which 
> is why we allow those drivers.
> 
> But switching an old one for a new one does not match that pattern. We can 
> clearly get regressions. As such, we don't do it late in the -rc series.

Are you aware the old one was introduced in 2.6.29-rc1? So there cannot be a
regression from 2.6.28 or older.

Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
