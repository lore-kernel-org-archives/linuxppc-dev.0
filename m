Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B5B0DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:05:16 +1100 (EST)
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
In-Reply-To: Your message of "Thu, 15 Feb 2007 10:45:54 MST."
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
Date: Thu, 15 Feb 2007 12:05:12 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HHkym-0005u5-HA@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Yoder Stuart-B08248" mumbled:
> 
> I like to see no space between the d#, h#, etc and the
> numeric value.

So, that's one of the really nice things about parsers.
Just do this, then:

    d23 = <d#23>;		// Just like <d# 23>!

The real question, though, is this:  MUST the space between
'd#' and '23' be removed so that it is all one token?
I suppose I could repaint that shed if needed, but I 
don't think it is.

jdl
