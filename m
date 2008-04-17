Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E86EBDED9F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 03:33:00 +1000 (EST)
Date: Thu, 17 Apr 2008 13:32:57 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 4/5] LED driver
Message-ID: <20080417133257.34d77bb7@lappy.seanm.ca>
In-Reply-To: <1208047290.5869.31.camel@vader.jdub.homelinux.org>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141039.25e14fae@lappy.seanm.ca>
	<1208047290.5869.31.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 Apr 2008 19:41:30 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> This should be sent to Richard Purdie.

I spoke with Richard and we agreed that, since the GPIO library will
make this driver obsolete, it is not worth committing this driver for,
hopefully, only one release.

If anybody sees any problems with this driver, I am still interested in
feedback since this driver will be used in the short term.

Cheers,
  Sean
