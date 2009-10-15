Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 31C88B7B89
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 05:39:42 +1100 (EST)
To: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121 CAN and USB
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4AD70927.3030401@marel.com>
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
	<4AD6FD4E.9060507@marel.com> <4AD70585.40302@gmail.com>
	<4AD70927.3030401@marel.com>
Date: Thu, 15 Oct 2009 20:30:39 +0200
Message-Id: <20091015183039.A577EECA6BE@gemini.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paul.gibson2074@gmail.com" <paul.gibson2074@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?=,

In message <4AD70927.3030401@marel.com> you wrote:
> 
> The kernel from the BSP on Freescale site is crashing on the CAN in my case
>  (might be a hardware bug).

I don;t think so. There are some problems in this code, for example
the clocks seem to be wrong. Not toi menthin that the whole code is
hoplessly old and without chance of ever being merged into mainline.

> I could not find the source for the kernel in the BSP or on the freescale site.

Extracting just the sources from LTIB (without actually building all
of it) is indeed not exactly easy.

> I had not looked at http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/ltib-mpc5121ads-20090602

Be careful. There are several branches that are intended for reference
only, or reflect work in progress. These are usually not intended for
use real use in a project:

The "ltib-mpc5121ads-20090602" branch reflects the exact state of the
kernel contained in the LTIB with this name (dated July 2009, despite
the name; based at 2.6.24.6, i. e. 7+ kernel versions behind).

The "mpc512x" branch contains a much smaller subset of drivers, but is
based on a more recent kernel tree (2.6.31-rc5) and is the base of our
(currently dozing) attempts to push this code into mainline.

> I am now in the progress of cloning the linux-mpc512x git from denx and building from it.
> Hopefully that will help me.

Do not do this. This old repository was intended for co-operation
with John Rigby, when he was still working for Freescale. It is a
dead end and totally unsupported. Guess I should remove it. Indeed.
Removed now. Sorry for the confusion.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Anyone who knows history, particularly the history of Europe, will, I
think, recognize that the domination of education or of government by
any one particular religious faith is never a happy  arrangement  for
the people.                                       - Eleanor Roosevelt
