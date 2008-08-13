Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Implement fdt_get_property_namelen() and
	fdt_getprop_namelen()
In-reply-to: <20080806045049.GC6690@yookeroo.seuss> 
References: <20080806045049.GC6690@yookeroo.seuss>
Date: Wed, 13 Aug 2008 13:09:44 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KTKn2-0000Jn-Fu@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> As well as fdt_subnode_offset(), libfdt includes an
> fdt_subnode_offset_namelen() function that takes the subnode name to
> look up not as a NUL-terminated string, but as a string with an
> explicit length.  This can be useful when the caller has the name as
> part of a longer string, such as a full path.
> 
> However, we don't have corresponding 'namelen' versions for
> fdt_get_property() and fdt_getprop().  There are less obvious use
> cases for these variants on property names, but there are
> circumstances where they can be useful e.g. looking up property names
> which need to be parsed from a longer string buffer such as user input
> or a configuration file, or looking up an alias in a path with
> IEEE1275 style aliases.
> 
> So, since it's very easy to implement such variants, this patch does
> so.  The original NUL-terminated variants are, of course, implemented
> in terms of the namelen versions.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
