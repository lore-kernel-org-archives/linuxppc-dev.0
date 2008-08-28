Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id AB9D7DDF10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 23:53:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 paul@mad-scientist.us
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
Date: Thu, 28 Aug 2008 15:53:17 +0200
References: <1219928864.16802.69.camel@homebase.localnet>
In-Reply-To: <1219928864.16802.69.camel@homebase.localnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281553.18167.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Paul Smith wrote:
> However, looking in the include/asm-ppc directory I see that many of the
> files that used to be there are not there anymore... although they do
> appear in include/asm-powerpc. =A0In particular I'm interested in
> ppc_asm.h which used to exist in both asm-ppc64 AND in asm-ppc, but now
> only exists in asm-powerpc. =A0What's the approved way to include this
> header if asm points to asm-ppc?
>=20
> In general it seems like lots of headers that used to be in both asm
> directories now appear in only asm-powerpc; I don't really see how this
> is supposed to work. =A0Any tips on this would be most welcome.
>=20

The easiest solution should be to just include all your modules in
the kernel source as patches, rather than building them externally.

That will give you access to all the headers you need.

Of course that is only possible if all your modules are GPL, but I
assume that you would not have asked here if they were not.

	Arnd <><
