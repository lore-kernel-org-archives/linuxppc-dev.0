Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DCC34B7B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 10:10:09 +1100 (EST)
To: Paul Gibson <paul.gibson2074@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121 CAN and USB
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com>
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
	<4AD6FD4E.9060507@marel.com> <4AD70585.40302@gmail.com>
	<4AD70927.3030401@marel.com>
	<20091015183039.A577EECA6BE@gemini.denx.de>
	<26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com>
Date: Fri, 16 Oct 2009 01:10:05 +0200
Message-Id: <20091015231005.D2CE9F15432@gemini.denx.de>
Cc: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Paul,

In message <26b052040910151603y8fc9b00g678d6a873083f1e7@mail.gmail.com> you wrote:
> 
> > The "ltib-mpc5121ads-20090602" branch reflects the exact state of the
> > kernel contained in the LTIB with this name (dated July 2009, despite
> > the name; based at 2.6.24.6, i. e. 7+ kernel versions behind).
> 
> I have diff'ed this and it is very similar to the ltib in the BSP.
> The MBX patches may be missing though.  These patches can be obtained
> via the Freescale SDK for the OpenGL on the MPC5121e webpage.

Who cares. This code is about 8 (!) kernel releases behind. Scrap
it.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Were there fewer fools, knaves would starve.              - Anonymous
