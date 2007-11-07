Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 38C24DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 12:19:59 +1100 (EST)
Date: Tue, 6 Nov 2007 19:19:43 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Medve Emilian <Emilian.Medve@freescale.com>
Subject: Re: [RFC/PATCH] reduce load time for modules with lots of relocs
Message-ID: <20071107011943.GM9695@localdomain>
References: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
	<20071101235728.GE9695@localdomain>
	<20071106023355.GJ9695@localdomain>
	<598D5675D34BE349929AF5EDE9B03E270174D37B@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174D37B@az33exm24.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Medve Emilian wrote:
> Would it be possible to do the sort "in place" (without the extra
> buffer)? I mean would that upset any other part of the kernel?

I suspect so.  Sounds like you've got the good testcase, maybe you
should try it and see.  :)
