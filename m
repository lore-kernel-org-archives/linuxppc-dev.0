Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 421CADDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 09:51:56 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1117284ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:51:54 -0700 (PDT)
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
From: Josh Boyer <jwboyer@gmail.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1214424332-18496-1-git-send-email-timur@freescale.com>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
Content-Type: text/plain
Date: Wed, 25 Jun 2008 19:51:49 -0400
Message-Id: <1214437909.14225.122.camel@weaponx>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-25 at 15:05 -0500, Timur Tabi wrote:
> +/**
> + * Return the first or next property within a node.
> + * @np: the node
> + * @prev: if NULL, return 1st prop, otherwise return the prop after 'prev'
> + *
> + * This function is used to get a list of properties within a node.  It's
> + * also useful for when you don't know the name of the propety you want to
> + * find.

How is this useful when you don't know the name of the property you want
to find?  I don't understand that at all.

I'm not really sure what good having a list of the properties within a
node is either, outside of using it for debugging.

josh
