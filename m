Return-Path: <hollis@penguinppc.org>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 660B5679EA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 07:02:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2SK2WDV010607
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 15:02:33 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2SK5ddP190564
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 13:05:39 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2SK2Wua012529
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 13:02:32 -0700
From: Hollis Blanchard <hollis@penguinppc.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: make install on ppc
Date: Tue, 28 Mar 2006 14:02:01 -0600
References: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
	<44298929.1060003@am.sony.com>
In-Reply-To: <44298929.1060003@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200603281402.02449.hollis@penguinppc.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 28 March 2006 13:06, you wrote:
> Problem is for multi-platform binary builds, 'install' could mean differe=
nt
> things for the different platforms, so to support install, there needs
> to be some way to tell the build system what 'install' means that also
> works with the muti-platform makefile logic. =C2=A0The current powerpc ma=
kefiles
> don't have this, and it would take some non-trivial rework to add it.

That is for the distribution- or user-supplied installkernel script to deal=
=20
with.

> There is also the question of what install means when cross building.

So don't run make install when cross-compiling (unless of course your=20
installkernel script supports that).

I don't understand these objections. If someone's platform is so super-spec=
ial=20
that a script couldn't possibly know how to install a kernel, just don't ru=
n=20
make install!

=2DHollis
