Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3C7D3DE13E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 05:21:06 +1000 (EST)
Date: Fri, 23 May 2008 23:20:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Suvidh Kankariya <suvidh.kankariya@ntigo.com>
Subject: Re: help with USB on mpc8313e
Message-ID: <20080523192049.GA14572@polina.dev.rtsoft.ru>
References: <48370DB6.7030003@ntigo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48370DB6.7030003@ntigo.com>
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

On Fri, May 23, 2008 at 02:32:22PM -0400, Suvidh Kankariya wrote:
> Hi,
> I am trying to use the mpc8313e internal usb phy with internal  
> oscillator frequency of  24 Mz. in host mode on a custom board.
> Whenever I plugin any low/fast speed device the device gets detected but  
> then always get an error
> "cannot read descriptor 64  error 71".Also I get address error after that .
>
> Can somebody point me what this error can be related to ?Can it be a  
> problem with ehci drivers or some configuration. (I get a valid clock  
> bit set in the status register).

This reminds me: http://patchwork.ozlabs.org/linuxppc/patch?id=17782
Was getting exactly same symptoms.

Try similar changes, should help.

> Also can someone point me how I include support for mmc on spi. I am  
> using kernel 2.6.20 that comes along with mpc8313e bsp.
>
> Any pointers are highly appreciable.
>
> Thanks in advance
> Regards
>
> Suvidh

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
