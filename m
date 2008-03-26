Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Trivial formatting fixes 
In-reply-to: <20080326052103.GB2090@localhost.localdomain> 
References: <20080326052103.GB2090@localhost.localdomain>
Date: Wed, 26 Mar 2008 08:15:35 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JeVTb-0005tQ-Ae@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch fixes some trivial indentation and brace/bracket style
> problems.


> @@ -179,9 +179,8 @@
>  		arg = argv[optind];
>  
>  	/* minsize and padsize are mutually exclusive */
> -	if ((minsize) && (padsize)) {
> +	if (minsize && padsize)
>  		die("Can't set both -p and -S\n");
> -	}


I do not consider extra braces a "problem", and will
not be applying those changes.  The other indentation
fixes will be applied, of course.

jdl
