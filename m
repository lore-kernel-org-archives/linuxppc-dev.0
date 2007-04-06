Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4616BC86.7020601@am.sony.com>
Date: Fri, 06 Apr 2007 14:32:54 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
References: <1175212972.3122.87.camel@pmac.infradead.org>
In-Reply-To: <1175212972.3122.87.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> It doesn't like it when we poke at legacy I/O ports like the i8042. We
> should probably change the _default_ to return -ENODEV, and let any
> strange platform which wants to allow unfettered access provide its own
> function for that.

I added this one to ps3-linux.git until support for a platform default
routine is made.

-Geoff 
