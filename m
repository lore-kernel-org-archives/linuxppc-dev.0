Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D7D92DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 19:53:27 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 28 Sep 2007 11:53:26 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <18172.15699.359375.286439@cargo.ozlabs.ibm.com>
Message-ID: <20070928095326.242700@gmx.net>
MIME-Version: 1.0
References: <20070927191233.201980@gmx.net>
	<18172.15699.359375.286439@cargo.ozlabs.ibm.com>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Fri, 28 Sep 2007 09:31:31 +1000
> Von: Paul Mackerras <paulus@samba.org>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?

> You appear to have a working 16550-style serial port which the udbg
> infrastructure sees.  Thus you should be able to use xmon, talking to
I couldn't get udbg running yet. Maybe i didn't specify a proper kernel
boot argument.

> it via the serial port.  Put "xmon" on the kernel command line and the
> kernel will drop into xmon early in the boot process (in setup_arch).
> Then, either the kernel will oops at some point and drop into xmon,
> and you can then inspect memory and registers and get a stack trace,
> or it will hang at some point.  If it hangs, you can work out where it
> hangs by putting in breakpoints at various points and seeing which
> breakpoints you get to (this might take several boots).
Okay, I'll investigate it. Is there a documentation for xmon (Google
wasn't really helpful in this case).

Thanks!

regards,

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
