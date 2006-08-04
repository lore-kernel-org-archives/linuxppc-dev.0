Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id A3417679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 07:00:29 +1000 (EST)
Subject: Re: ELDK 3.1.1 support for x86_64 host architecture
From: Ben Warren <bwarren@qstreams.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060804201127.00D2D352640@atlas.denx.de>
References: <20060804201127.00D2D352640@atlas.denx.de>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 17:00:25 -0400
Message-Id: <1154725225.5020.7.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: Michael Carey <MCarey@nearfield.com>, linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-04 at 22:11 +0200, Wolfgang Denk wrote:

> Yes, SuSE has always found interesting ways to  break  compatibility.
> That's  why  I avoid it. IIRC, SuSE provides a special tool "linux32"
> which has to be used to run 32-bit applications on a x86_64 system.
> 
> Don't ask  me  why  they  need  it.  Other  distros  run  the  32-bit
> applications just fine without such intricacy.
> 
> 
I don't know about SUSE, but to get ELDK 4.0 running on my Debian x86_64
server I had to install a package called 'ia32_libs'.

regards,
Ben
