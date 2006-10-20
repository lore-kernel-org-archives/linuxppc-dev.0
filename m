Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9486E67BBE
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 09:23:29 +1000 (EST)
Date: Fri, 20 Oct 2006 18:22:03 -0500
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: Selecting the ppc_md.power_save method at boot time
Message-ID: <20061020182203.7871d1b1@pb15>
In-Reply-To: <200610201840.14389.arnd.bergmann@de.ibm.com>
References: <200610201840.14389.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Anthony J Marsala <marsala@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006 18:40:13 +0200 Arnd Bergmann <arnd.bergmann@de.ibm.com> wrote:

> 2. Make it possible to have multiple implementations, e.g.
> powersave=cbe, powersave=nap, powersave=cede, powersave=off,
> powersave=power4, with a per-platform default.

Doesn't make a whole lot of sense, since there's no way to use the
power4 powersave on a cell system -- specifying it on the command line
won't do much good.

> Is anyone interested in the second solution? Otherwise I'd post
> a simple patch to just do powersave=off.

Gobal powersave=off sounds good, specific platforms could implement
others as needed.


-Olof
