Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Add function to explicitly expand aliases 
In-reply-to: <20080820065514.GA18996@yookeroo.seuss> 
References: <20080820065514.GA18996@yookeroo.seuss>
Date: Thu, 02 Oct 2008 08:55:28 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KlOeO-0007Dw-95@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Kumar has already added alias expansion to fdt_path_offset().
> However, in some circumstances it may be convenient for the user of
> libfdt to explicitly get the string expansion of an alias.  This patch
> adds a function to do this, fdt_get_alias(), and uses it to implement
> fdt_path_offset().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
