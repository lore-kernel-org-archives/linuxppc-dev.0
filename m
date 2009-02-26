Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 73D63DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 04:40:33 +1100 (EST)
Date: Thu, 26 Feb 2009 18:40:31 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Mark Nelson <markn@au1.ibm.com>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
In-Reply-To: <200902261020.34325.markn@au1.ibm.com>
Message-ID: <alpine.LRH.2.00.0902261805510.29190@vixen.sonytel.be>
References: <49A2705D.9030008@in.ibm.com>
	<alpine.LRH.2.00.0902251430410.4063@vixen.sonytel.be>
	<200902260945.41990.markn@au1.ibm.com>
	<200902261020.34325.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Jan Kara <jack@ucw.cz>, Jan Kara <jack@suse.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2009, Mark Nelson wrote:
> On Thu, 26 Feb 2009 09:45:41 am Mark Nelson wrote:
> > On Thu, 26 Feb 2009 12:31:20 am Geert Uytterhoeven wrote:
> > > On Wed, 25 Feb 2009, Mark Nelson wrote:
> > > > Does the following patch fix the errors you're seeing? (it applies the
> > > > same fix as the previous patch but this time to copy_tofrom_user, which
> > > > I updated in a4e22f02f5b6518c1484faea1f88d81802b9feac)
> > > 
> > > Thanks, but I still get crashes in copy_page_range().
> > 
> > Hmmm... I'm out of ideas for the moment, but thanks for testing anyway!
> 
> If you revert both 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556 and
> a4e22f02f5b6518c1484faea1f88d81802b9feac, does it help? You could also
> try to revert 57dda6ef5bd5b9e60410477ad29e654097e2cca1 just in case I
> need to keep wearing the brown paper bag for a bit longer :)

Still doesn't help.

However, I noticed I never enabled CONFIG_DEBUG_PAGEALLOC before 2.6.29-rc5.
So far I tried 2.6.2[5-8], and they all crash with CONFIG_DEBUG_PAGEALLOC.
I guess it never actually worked on PS3.

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
