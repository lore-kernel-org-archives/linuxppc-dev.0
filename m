Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17911.31508.878043.41229@cargo.ozlabs.ibm.com>
Date: Wed, 14 Mar 2007 15:33:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add dt_ops methods.
In-Reply-To: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
References: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> +static inline void *find_node_by_prop_value_str(const void *prev,
> +                                                const char *propname,
> +                                                const char *propval)

That name sure is a mouthful.  Since we mostly (only?) use it with
propname == "device_type", why not make a helper with a nice,
(relatively) short name like "find_node_by_type" for that case?

Paul.
