Return-Path: <SRS0+42d8bef273a168602f5e+519+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94D7F67AA5
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jan 2005 02:47:27 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: David Medina <ibookdebian@gmail.com>
In-Reply-To: <6ecd913805012402451b425320@mail.gmail.com>
References: <6ecd913805012402451b425320@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 15:43:34 +0000
Message-Id: <1106581414.6480.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Java/eclipse in PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-24 at 11:45 +0100, David Medina wrote:
>  I have a Ibook G4 (the last - 23.01.05) where are installed
> Debian Ubuntu 4.01 to PPC (logical)
> I want to install Java and Eclipse to development. The SDK of
> Java is "easy" because can be downloaded to www.ibm.com the version
> "1.4.2 SR1"

There are packages in Fedora rawhide which use gcj. They seem to work
for me on a FC3 installation. You may be able to use those in Debian;
I'm not sure.

-- 
dwmw2
