Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2D8A3DE2F6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:27:35 +1000 (EST)
Date: Thu, 26 Jun 2008 14:27:32 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
Message-ID: <20080626142732.0ff6e64c@lappy.seanm.ca>
In-Reply-To: <4863BBE2.2060107@freescale.com>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
	<4863B1C1.1060300@freescale.com> <200806261751.05379.sr@denx.de>
	<4863BBE2.2060107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jun 2008 10:55:14 -0500
"Timur Tabi" <timur@freescale.com> wrote:

> Well, there's a lot of disagreement on this subject.  Not only do we
> not agree on a method of enumerating devices, a lot of people have a
> problem with the concept of enumerating them in the first place!

An interesting point is that I enforced an index in the i2c-ibm_iic
driver with no disagreement at all ;)

Cheers,
   Sean
