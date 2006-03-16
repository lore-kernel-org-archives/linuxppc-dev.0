Return-Path: <benh@kernel.crashing.org>
Subject: Re: RFC: [PATCH Upated]: snd-pmac-gpio interfaces for snd-powermac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1142445631.4670.9.camel@localhost>
References: <1137630485.4425.2.camel@grayson>
	<1142445631.4670.9.camel@localhost>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 10:54:27 +1100
Message-Id: <1142553267.14988.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-03-15 at 19:00 +0100, Johannes Berg wrote:

> Maybe there ought to be a way to disable the fallback when we're on
> newer chips? I don't grok the sound architecture well enough yet to
> tell.

I think we should only use the pfuncs on k2 (ppc64) or when the macio
node contains the include-k2-support property. At least, I +think+
that's what darwin is doing.
