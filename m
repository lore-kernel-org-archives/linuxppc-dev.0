Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC 3/3] zImage: Exception vector support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45DB1759.2010302@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com>  <45DB1759.2010302@am.sony.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:06:13 +0100
Message-Id: <1172250373.1902.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Having those vectors makes a 4MB dead gap in the binary image.  The ps3's
> loader supports a gziped image so there is no problem, but for the general
> case of binary images, there is no way we can have those always in there.

That's still a bit gross even with a zImage... right now, I don't think
you can specify the link address per platform, can you ? Would be better
if it was set to 0 for ps3... that or have the reset vector be at BASE +
0x100 ...

Ben.
