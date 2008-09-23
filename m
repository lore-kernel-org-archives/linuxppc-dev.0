Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 247E0DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 16:01:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: Regarding select() on PPC
Date: Tue, 23 Sep 2008 08:01:33 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
	<200809230746.03234.arnd@arndb.de>
	<1222149361.12085.101.camel@pasglop>
In-Reply-To: <1222149361.12085.101.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809230801.33508.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 23 September 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-09-23 at 07:46 +0200, Arnd Bergmann wrote:
> > I would definitely switch over the ppc32 __NR_newselect implementation
> > to sys_select. For __NR_select, there is no correct solution, the three
> > options are the current ppc_select, the real sys_select or sys_ni_syscall.
> > Each of these is broken in different ways, but in practice it will never
> > be called anyway.
> > 
> > I love archeology.
> 
> Any idea when glibc got fixed ?
> 

No, sorry, I don't have a git history that I can search for that.
I have a strong guess that it would be the end of the last century
though, probably before 2.3.48, since the comment in there already
refers to legacy binaries.

	Arnd <><
