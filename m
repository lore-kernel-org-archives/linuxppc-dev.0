Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 51BE767B5A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 05:06:13 +1000 (EST)
Date: Thu, 20 Jul 2006 14:05:23 -0500
To: "Brian D. Carlstrom" <bdc@carlstrom.com>
Subject: Re: AltiVec in the kernel
Message-ID: <20060720190523.GA27775@pb15.lixom.net>
References: <20060719181047.GL5905@austin.ibm.com>
	<001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
	<20060720174255.GP5905@austin.ibm.com>
	<le8xmoktav.wl%bdc@carlstrom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <le8xmoktav.wl%bdc@carlstrom.com>
From: Olof Johansson <olof@lixom.net>
Cc: 'Paul Mackerras' <paulus@samba.org>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2006 at 11:47:04AM -0700, Brian D. Carlstrom wrote:

> A quick grep memcpy in the recent glibc sources on my linux/ppc box
> seems to show no where near that level of optimization, but I admit
> that I could have missed something.

http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html


-Olof
