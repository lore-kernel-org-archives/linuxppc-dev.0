Return-Path: <jdl@jdl.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] libfdt: Add support for using aliases in
	fdt_path_offset()
In-reply-to: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net> 
References: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
Date: Thu, 14 Aug 2008 10:24:48 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KTegy-0002dY-9M@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If the path doesn't start with '/' check to see if it matches some alias
> under "/aliases" and substitute the matching alias value in the path
> and retry the lookup.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied.

jdl
