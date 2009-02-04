Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10077DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 10:05:59 +1100 (EST)
Subject: Re: Dynamic-ftrace not working in PlayStation3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0902041650240.18695@gandalf.stny.rr.com>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
	<4983BFA2.9010703@am.sony.com> <200901311125.34755.arnd@arndb.de>
	<alpine.DEB.1.10.0902041650240.18695@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 10:05:23 +1100
Message-Id: <1233788723.4612.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> OK, I've been able to reproduce it. It looks like the assumptions of the 
> trampoline that I've made is not correct if the size of the module is over 
> some limit.  I had to make usb-core into a module, and I see the same 
> bug.
> 
> I'll take a deeper look into it.

Thanks ! I've been a bit swamped lately and didn't get a chance to dig
into that one .. yet. Let me know if you are stuck tho.

Cheers
Ben.
