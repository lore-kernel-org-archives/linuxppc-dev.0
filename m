Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DAEF3DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:51:05 +1100 (EST)
Date: Thu, 15 Feb 2007 12:00:08 -0600
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070215180008.GA25247@lixom.net>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 10:45:54AM -0700, Yoder Stuart-B08248 wrote:
> 
> I like to see no space between the d#, h#, etc and the
> numeric value.
> 
> Does anyone see a good reason to keep whitespace there?

Does it really matter what color the bike shed is?

http://www.unixguide.net/freebsd/faq/16.19.shtml

(I've seen 0x<hex> <decimal> or 0d<decimal> and 0b<binary> been used
sometimes and work well, but I really don't care if it's what the dtc
uses or not.)

-Olof
