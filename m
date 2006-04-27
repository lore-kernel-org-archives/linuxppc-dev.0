Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8218B679F9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:43:18 +1000 (EST)
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot-Users] Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 15:33:28 EDT."
	<44511C88.1010107@smiths-aerospace.com>
Date: Thu, 27 Apr 2006 21:43:16 +0200
Sender: wd@denx.de
Message-Id: <20060427194316.CBFBC353A57@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <44511C88.1010107@smiths-aerospace.com> you wrote:
> 
> A thought that keeps recurring (but I've suppressed because I don't have 
> time to play...) is that it would be Really Cool[tm] to store the u-boot 
> env variables in a flat tree and then pass the env/tree to linux.  It 

If somebody wants to read the environment variables, you  don't  need
to create a flat tree from it.

Also, it doesn't solve the original problem as most of  the  informa-
tion  you  need to pass is NOT part of the environment (and shall not
become such a part).


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I thought my people would grow tired of killing. But you were  right,
they  see it is easier than trading. And it has its pleasures. I feel
it myself. Like the hunt, but with richer rewards.
	-- Apella, "A Private Little War", stardate 4211.8
