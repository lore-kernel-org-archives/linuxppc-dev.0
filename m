Return-Path: <olof@lixom.net>
Date: Thu, 29 Mar 2007 20:45:42 -0500
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Implement check_legacy_ioport() on PS3
Message-ID: <20070330014542.GA28342@lixom.net>
References: <1175212972.3122.87.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175212972.3122.87.camel@pmac.infradead.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 30, 2007 at 01:02:52AM +0100, David Woodhouse wrote:
> It doesn't like it when we poke at legacy I/O ports like the i8042. We
> should probably change the _default_ to return -ENODEV, and let any
> strange platform which wants to allow unfettered access provide its own
> function for that.

I ran into the very same thing earlier myself and had exactly the same
idea. However, it turned out then that it would have meant adding more
cases of ioport being allowed than it would have removed the opposite. It
might have changed since then. Either way it's annoying.


-Olof
