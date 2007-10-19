Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 80775DDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 05:04:32 +1000 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Oct 2007 11:36:34 CDT."
	<20071019113634.397c63f7@weaponx.rchland.ibm.com>
Date: Fri, 19 Oct 2007 21:04:30 +0200
Sender: wd@denx.de
Message-Id: <20071019190430.1C6B2243CA@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Josh,

in message <20071019113634.397c63f7@weaponx.rchland.ibm.com> you wrote:
>
> >  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> > The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> > built using the modified version of binutils, where the MAXPAGESIZE 
> > definition is set to 0x40000 (as opposite to standard 0x10000).
...
> 
> BTW, what tree did you base this on?  I don't seem to have the
> PPC_PAGE_* options in my tree.

If you like to see the patches in context, you can find this stuff in
the linux-2.6-denx repository at denx.de

The 256K page size stuff is based on and requires as prerequisite the
"ppc: Add support for bigger page sizes than 4KB on PPC44x" posted
here on April 25, see
http://patchwork.ozlabs.org/linuxppc/patch?q=Add%20support%20for%20bigger%20page%20sizes&id=10646

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Q: Why do PCs have a reset button on the front?
A: Because they are expected to run Microsoft operating systems.
