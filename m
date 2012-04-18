Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6C44B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 00:28:55 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc: Require gcc 4.0 on 64-bit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120418144254.3286ce94@kryten>
Date: Wed, 18 Apr 2012 09:28:42 -0500
Message-Id: <85510A09-D78C-432E-AAED-A0FB49D5325A@kernel.crashing.org>
References: <20120418144254.3286ce94@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 17, 2012, at 11:42 PM, Anton Blanchard wrote:

>=20
> Older versions of gcc had issues with using -maltivec together with
> -mcpu of a non altivec capable CPU. We work around it by specifying
> -mcpu=3D970, but the logic is complicated.
>=20
> In preparation for adding more -mcpu targets, remove the workaround
> and just require gcc 4.0 for 64-bit builds.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> 4.0 came out in 2005 and the gcc on RHEL5 and SLES10 looks to be 4.1.
> I highly doubt a ppc64 kernel will build these days on either RHEL4 or
> SLES9.
>=20
> Anything else we have to worry about?

There are probably embedded customers that might utilize older =
compilers, so this concerns me a little.

- k=
