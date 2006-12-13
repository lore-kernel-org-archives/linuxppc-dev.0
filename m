Return-Path: <Geoff.Thorpe@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B057467CBE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 04:48:52 +1100 (EST)
Message-ID: <45803CFF.7090404@freescale.com>
Date: Wed, 13 Dec 2006 12:48:47 -0500
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>	<1165890570.11914.5.camel@localhost.localdomain>	<457F1F6E.4020502@freescale.com>	<1165960058.11914.72.camel@localhost.localdomain>	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>	<20061212162416.06f0dd76.kim.phillips@freescale.com>	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>	<457F2FE1.1080308@freescale.com>
	<513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
	<457F8EC3.60201@freescale.com>
	<2B135C85-9FF6-435E-975B-D0D3E7ACFF5B@kernel.crashing.org>
In-Reply-To: <2B135C85-9FF6-435E-975B-D0D3E7ACFF5B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

'day,

I'm inclined to defer to the maintainer's prerogative of judging the 
acceptability of code. :-) Thanks for responding.

However I have a couple of little responses regarding other matters;

Kumar Gala wrote:

> There are a number of subtle reasons I think a generic port is  
> pointless and the only arguments I've heard are some concern about  
> duplication of code and the ability to boot a kernel w/o modification  
> on new HW.


To each their own "concern" I guess. "Duplication of code and the 
ability to boot a kernel w/o modification on new HW" both seem like 
pretty legitimate concerns to me. That this may or may not be acceptable 
on a technical level should be the focus, but it seems irrational to 
presume to stipulate what interests/concerns other hackers should and 
should not have? This is linux, not windows.

> The duplication code I believe is a style issue and we can reduce the  
> duplication to a minimum.  The ability to boot a kernel w/o  
> modification on new HW is a nice to have, but I dont see this as  
> providing any "real value".


Same comment.

> I'd rather see people spending time on problems which need solutions  
> and this isn't one of them.


Um, with all due respect. You are invoking what could only be described 
as "employer's privilege". I doubt the concern here came purely from 
someone having nothing better to do and being totally lost for ideas. No 
doubt they'll correct me if I'm wrong :-)

I have no comment on your technical objections, only the(se) 
non-technical one(s).

(Seasonal) cheers,
Geoff
