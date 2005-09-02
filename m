Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Fri, 2 Sep 2005 05:18:32 +0200
References: <1125607912.16685.111.camel@cashmere.sps.mot.com>
In-Reply-To: <1125607912.16685.111.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509020518.32732.arnd@arndb.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH Merge more include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dunnersdag 01 September 2005 22:51, Jon Loeliger wrote:
> +/*
> + * This file is included by 'init/main.c' to check for
> + * architecture-dependent bugs.
> + */
> +
> +extern void check_bugs(void);
> +

Actually, I think this could to be 

+static inline void check_bugs(void)
+{
+}

The function is empty on both ppc and ppc64, so we can just as
well get rid of the symbol as well.
The rest of the patch looks perfect to me.

	Arnd <><
