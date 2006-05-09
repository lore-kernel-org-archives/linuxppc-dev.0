Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 817C9679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 08:31:16 +1000 (EST)
To: Eugene Surovegin <ebs@ebshome.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Viable PPC platform? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 May 2006 10:15:20 PDT."
	<20060509171520.GA10886@gate.ebshome.net>
Date: Wed, 10 May 2006 00:31:13 +0200
Sender: wd@denx.de
Message-Id: <20060509223113.5715D353DB1@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060509171520.GA10886@gate.ebshome.net> you wrote:
>
> After many years of doing embedded Linux stuff I still don't 
> understand why people are so fond of initrd.
> 
> For temporary stuff - tempfs is much better and flexible. For r/o 
> stuff - just make separate MTD partition (cramfs, squashfs) and mount 
> it directly as root. Both options will waste significantly less 
> memory.

Agreed.

And if somebody wants to see facts and numbers, please see
http://www.denx.de/wiki/view/DULG/RootFileSystemSelection

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Ninety-Ninety Rule of Project Schedules:
        The first ninety percent of the task takes ninety percent of
the time, and the last ten percent takes the other ninety percent.
