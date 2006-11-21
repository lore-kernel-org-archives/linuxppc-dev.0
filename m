Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E2EB367C9A
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:11:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Date: Tue, 21 Nov 2006 11:11:12 +0100
References: <4554DACB.8060809@am.sony.com> <4559099A.6060805@am.sony.com>
	<17762.26999.152198.792581@cargo.ozlabs.ibm.com>
In-Reply-To: <17762.26999.152198.792581@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611211111.12882.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 November 2006 03:50, Paul Mackerras wrote:
> The "ps3pf" name is pretty meaningless. =A0I think that, at the very
> least, the directory name should be arch/powerpc/platforms/ps3.
> Unless Arnd is prepared to argue strongly to the contrary, I will be
> rejecting patches that create a platforms/ps3pf directory.

I don't care about the name at all, either way. However, I think it
would be good to be consistant with the directory name and the name
of identifiers in the code, so the function names should also be
changed if the platform is name 'ps3'.

	Arnd <><
