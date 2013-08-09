Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 04A822C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 00:42:00 +1000 (EST)
Subject: Re: [RFC] powerpc: put the common parts of the ppc64*defconfigs in a
 Kconfig file
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
Date: Fri, 9 Aug 2013 09:41:54 -0500
Message-Id: <37F6E4C6-0428-4707-A46A-B9DB9A145747@kernel.crashing.org>
References: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2013, at 1:24 AM, Stephen Rothwell wrote:

> We cannot put the unsetting of config options in the Kconfig file, nor
> the integer or string options.
>=20
> I checked that after this we get the same .config files generated =
(except
> for the addition of the new PPC64_DEFCONFIG* config options.
>=20
> Any thoughts?
> ---
> arch/powerpc/Kconfig                  |   2 +
> arch/powerpc/configs/Kconfig          | 295 =
+++++++++++++++++++++++++++++++++
> arch/powerpc/configs/ppc64_defconfig  | 301 =
+---------------------------------
> arch/powerpc/configs/ppc64e_defconfig | 297 =
+--------------------------------
> 4 files changed, 302 insertions(+), 593 deletions(-)
> create mode 100644 arch/powerpc/configs/Kconfig

Am I missing something here, isn't this a bit of a maintenance pain if =
symbol names change?

Also, how much of a benefit is this?

- k=
