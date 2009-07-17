Return-Path: <roel.kluin@gmail.com>
Received: from mail-bw0-f207.google.com (mail-bw0-f207.google.com
	[209.85.218.207])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A8D5CB709C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 01:19:18 +1000 (EST)
Received: by bwz3 with SMTP id 3so781467bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 08:19:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907171705.18578.arnd@arndb.de>
References: <4A607185.6020302@gmail.com> <200907171705.18578.arnd@arndb.de>
Date: Fri, 17 Jul 2009 17:19:15 +0200
Message-ID: <25e057c00907170819k6c8cd8edw5011c440fff45029@mail.gmail.com>
Subject: Re: [PATCH] powerpc/cell: strncpy does not null terminate string
From: roel kluin <roel.kluin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> With `sizeof(string) - 1` strncpy() will null terminate the string.
>
> No, it won't.

> See the line after the strncpy. This is still required for proper zero-termination.

You're right, sorry for the noise.

Roel
