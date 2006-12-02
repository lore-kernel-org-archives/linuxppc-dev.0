Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 986AD67B6C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 20:31:42 +1100 (EST)
In-Reply-To: <1165049149754-git-send-email-grant.likely@secretlab.ca>
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<1165049149754-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <596B6F7D-9646-471C-A5E0-F3606A89B147@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [LIBFDT] Add .dtb files to .gitignore
Date: Sat, 2 Dec 2006 10:30:59 +0100
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/.gitignore b/.gitignore
> index 4b147f1..42b3e35 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,3 +3,4 @@
>  *.a
>  *.so
>  *~
> +tests/*.dtb

You should put this in tests/.gitignore, instead.


Segher
