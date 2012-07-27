Return-Path: <john@stoffel.org>
Received: from mycroft.westnet.com (Mycroft.westnet.com [216.187.52.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.westnet.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A62EB2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 00:26:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <20498.41365.853741.261834@quad.stoffel.home>
Date: Fri, 27 Jul 2012 10:11:33 -0400
From: "John Stoffel" <john@stoffel.org>
To: <sandeep@freescale.com>
Subject: Re: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> From: Sandeep Singh <Sandeep@freescale.com>
> TDM Framework is an attempt to provide a platform independent layer which can
> offer a standard interface  for TDM access to different client modules.

Please don't use TLAs (Three Letter Acronyms) like TDM without
explaining the clearly and up front.  It makes it hard for anyone else
who doens't know your code to look it over without having to spend
lots of time poking around to figure it out from either context or
somewhere else.

John
