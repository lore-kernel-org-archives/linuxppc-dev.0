Return-Path: <dale@farnsworth.org>
Date: 29 Oct 2007 10:27:24 -0700
Message-ID: <20071029172724.11354.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: scottwood@freescale.com, Linuxppc-dev@ozlabs.org
Subject: Re: RFC:  replace device_type with new "class" property?
In-Reply-To: <20071029161140.GA4358@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<4725FA58.4030505@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott wrote:
> Personally, I'm fine with just using name and compatible, but others such as
> Stuart have expressed a desire for something to formally indicate compliance
> with a standard binding.  I don't think we should expand the use of
> device_type in any case.

I agree that the existing compatible property is sufficient to do
what Stuart wants.  All that is required is to define some standard
bindings and give them well-known names for the compatible property.
If needed, we could define a prefix that indicates that a compatible
entry refers to a standards-compliant binding.  For example,
"standard,network", or "standard,display".  I don't see the benefit
of creating a new property similar to device_type.

-Dale
