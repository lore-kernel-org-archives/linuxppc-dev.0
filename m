Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9B9B0DE7ED
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 04:20:56 +1000 (EST)
To: Daniele Bosi <d.bosi@selcomgroup.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gdb problems with threads on mpc512x
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <48B28A65.2050409@selcomgroup.com>
References: <48B28A65.2050409@selcomgroup.com>
Date: Mon, 25 Aug 2008 20:20:53 +0200
Sender: wd@denx.de
Message-Id: <20080825182053.B804B248CA@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Daniele Bosi,

In message <48B28A65.2050409@selcomgroup.com> you wrote:
>
> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
> <html>

Please post plain text only on mailing lists.

> I encountered several problem debugging multithreated software with gdb
> on mpc512x, remotely (gdbserver) and locally.<br>
> I built gdb 6.8 from scratch, but it's crashing when I stop execution
> into a thread.<br>
> <br>
> Did anyone get it to work correctly?<br>

We use GDB 6.7 in our ELDK 4.2; we didn't encounter such problems in
our tests.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I often quote myself; it adds spice to my conversation.  - G. B. Shaw
