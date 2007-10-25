Return-Path: <david-b@pacbell.net>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by ozlabs.org (Postfix) with SMTP id 0A799DDE99
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 11:50:08 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Matt Sealey <matt@genesi-usa.com>,
	Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
Date: Wed, 24 Oct 2007 18:50:05 -0700
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
In-Reply-To: <471FC191.6020704@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710241850.05467.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 October 2007, Matt Sealey wrote:
> Can we just make sure real quickly that the changing of compatibles
> doesn't break existing, not-easily-flashable firmwares?

Yeah, I'm not keen on such breakage either...
