Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7D11EDDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Dec 2008 03:01:40 +1100 (EST)
To: "A. Nolson" <alohanono@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
    linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Weird strings in kernel uname when cross-compiling
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20081204064414.3b72ba91@zod.rchland.ibm.com>
References: <4937C1D1.5010002@gmail.com>
	<20081204064414.3b72ba91@zod.rchland.ibm.com>
Date: Thu, 04 Dec 2008 17:01:36 +0100
Message-Id: <20081204160136.A6EE3834B020@gemini.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Albert,

In message <20081204064414.3b72ba91@zod.rchland.ibm.com> Josh Boyer wrote:
> 
> >  anybody knows why every time I cross-compile my kernel (Denx 4.2 
> > cross-compiling chain ) I get an extra string in my vermagic like this
> > 
> > 2.6.24-rc3-gd7ed933b-dirty
...
> >  Having that is a bit annoying when I try to natively compile modules, 
> > so I need to workaround it by copying  that extra string into my other 
> > Makefiles. Anybody knows how to get rid of it?

It seems you don;t use the kernel's Makefile to build your modules,
which is a problem in itself. You should fix that first.

> It gets added on if you are building from a git repository and you have
> CONFIG_LOCALVERSION_AUTO set.  Disable that and it should go away.

Note that disabling this is strongly  discouraged  as  the  "annoying
extra  string"  is  extremely  useful  -  it allows for exact version
ideltification of the kernel you are using, including the  fact  that
you have modified but uncommited files in your tree.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The universe, they said, depended for its operation on the balance of
four forces which they identified as charm,  persuasion,  uncertainty
and bloody-mindedness.      -- Terry Pratchett, "The Light Fantastic"
