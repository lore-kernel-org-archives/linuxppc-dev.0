Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0883B1A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:11 +1000 (AEST)
In-Reply-To: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>
Subject: Re: powerpc: Kconfig: remove BE-only platforms from LE kernel build
Message-Id: <20151002074710.99988140B00@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-06-09 at 23:58:00 UTC, Boqun Feng wrote:
> Currently, little endian is only supported on powernv and pseries,
> however, Kconfigs still allow us to include other platforms in a LE
> kernel, this may result in space wasting or even build error if some
> BE-only platforms always assume they are built for a BE kernel. So just
> modify the Kconfigs of BE-only platforms to remove them from being built
> for a LE kernel.
> 
> For 32bit only platforms, nothing needs to be done, because
> CPU_LITTLE_ENDIAN depends on PPC64. For 64bit supported platforms, add
> CPU_BIG_ENDIAN to dependencies explicitly, so that these platforms will
> be disabled for LE [Suggested-by: Cédric Le Goater <clg@fr.ibm.com>].
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5e16d8f3ec6973af2068897

cheers
