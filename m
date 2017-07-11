Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6PTB1MJfzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 00:23:41 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gleb Fotengauer-Malinovskiy' <glebfm@altlinux.org>, Aleksa Sarai
 <asarai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Valentin Rothberg
 <vrothberg@suse.com>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dmitry V.
 Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christian Brauner
 <christian.brauner@ubuntu.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Date: Tue, 11 Jul 2017 14:23:29 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Linuxppc-dev  Gleb Fotengauer-Malinovskiy
> Sent: 11 July 2017 01:12
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>=20
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
...
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */

This is a user API change. When was the ioctl added?

	David
