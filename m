Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x658G5dCNzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 12:07:57 +1000 (AEST)
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin"
 <ldv@altlinux.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <f1cac5bf-d34f-9684-b27b-20e973f454a0@suse.de>
Date: Tue, 11 Jul 2017 12:07:43 +1000
MIME-Version: 1.0
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.

   Acked-by: Aleksa Sarai <asarai@suse.de>

Oops, I misunderstood what _IOR means semantically. TIL -- thanks!

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
