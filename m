Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 51541686FC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Nov 2005 18:27:22 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 7 Nov 2005 09:27:12 +0200
References: <61BDFF5614E6D3119B6E00508B446754037CD88D@mail.digital-dispatch.com>
In-Reply-To: <61BDFF5614E6D3119B6E00508B446754037CD88D@mail.digital-dispatch.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511070827.13130.david.jander@protonic.nl>
Cc: David Zhang <David.Zhang@digital-dispatch.com>
Subject: Re: problems on isp1362 driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 15 July 2005 02:14, David Zhang wrote:
>[...]
> We are using Philips ISP1362 USB controller on WinCE 4.2.  It seems that we
> are encountering "ATL interrupt" missing problem.  I am wondering if any of
> you ever had the similar problem.

Where does this driver come from? Does it have anything to do with linux 
kernel versions of that driver? If so, which one, 2.4 or 2.6?

I don't know WinCE, much less how drivers work in WinCE. Please specify what's 
the relationship (or expected relationship) with linux. In any case, you'd 
have to tell more details about the problem you're experiencing, otherwise 
it's unlikely someone here can help you.

I am using the isp116x HCD driver from kernel 2.6 now with a isp1160 chip, and 
it runs fine. I suppose you are talking about the Host part of the 1362?

Greetings,

-- 
David Jander
