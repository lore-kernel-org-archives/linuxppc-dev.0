Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8FD4ADE017
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 22:06:33 +1000 (EST)
Date: Mon, 26 May 2008 16:06:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
Message-ID: <20080526120632.GC26288@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163901.GE16137@polina.dev.rtsoft.ru>
	<48379A6B.4080300@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48379A6B.4080300@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 11:32:43PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>
>> 3. QE Serial UCCs (tested to not work with ucc_uart driver, reason
>>    unknown, yet);
>
> How far did you get on debugging this?

Right up to an oscilloscope. :-) With latest QE ram update I can see
that ucc_uart is able to transmit the data, but receiver is unable get
anything (RDK has two ucc_uarts with rs485 transceivers, I looped
them back).

Anyway, I would probably spent more time on it if I didn't have to
always rebase&resend this over and over again without any substantial
changes. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
