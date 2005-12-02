Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 605406884B
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2005 02:35:54 +1100 (EST)
To: "Redondo Garcia, Roberto" <rredondo@indra.es>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Dec 2005 11:33:46 +0100."
	<6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
Date: Fri, 02 Dec 2005 16:35:52 +0100
Sender: wd@denx.de
Message-Id: <20051202153552.49244353A14@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: back trace when a SIGSEGV 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es> you wrote:
> 
> I have a program that when it has been several hours running, it has a
> problem and falls and it produces a SIGSEGV.  I would like to know to
> how debug this error, because I do not have ulimit for generate core
> dump o examine a back trace.

Run the program under control of a debugger (gdb, or - if you're on a
resource-limited target - gdbserver).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Es ist nicht genug zu wissen, man muﬂ auch anwenden; es ist nicht ge-
nug zu wollen, man muﬂ auch tun.   -- Goethe, Maximen und Reflexionen
