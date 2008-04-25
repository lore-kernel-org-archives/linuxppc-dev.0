Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7D10CDDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 17:18:11 +1000 (EST)
Date: Fri, 25 Apr 2008 09:18:07 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: missing current-speed property prevents autoconsole on pegasos
Message-ID: <20080425071807.GA18058@aepfle.de>
References: <20080423152206.GA10935@aepfle.de>
	<4810AA6B.9010102@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4810AA6B.9010102@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, Matt Sealey wrote:

> Why not just have users who wish to use console serial port autodetection
> add 3 lines to their nvramrc?

The point of autodetection is that no userinteraction is required.

I guess the serial driver does not probe the configured hardware port
speed anymore (if it ever did that).
