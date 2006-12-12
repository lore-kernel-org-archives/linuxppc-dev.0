Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 43DF767C10
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 12:18:02 +1100 (EST)
To: "Russell McGuire" <rmcguire@uwbt.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8360E Startup - CFG_INIT_RAM 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Dec 2006 15:05:42 PST."
	<000801c71d78$e28cae60$6405a8c0@absolut>
Date: Tue, 12 Dec 2006 02:17:59 +0100
Sender: wd@denx.de
Message-Id: <20061212011759.D6839353BC7@atlas.denx.de>
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

Dear Russel,

in message <000801c71d78$e28cae60$6405a8c0@absolut> you wrote:
> 
> I am porting U-boot to a new custom MPC8360E based board.

You're off topic here. You should post such things on the
U-Bootmailing list instead.

> I have downloaded the GIT U-boot tree, and see that DENX has made an example
> for the MPC8360E-MDS board, and it is an excellent start. <If anyone is

No, the MPC8360EMDS was not done by us, but by Dave Liu; see the
MAINTAINERS file for details.

> My question lies with what value to place in the CFG_INIT_RAM address. 

See the "Note:" in the README...

> Due to the massive amount of flash on our board <128M>, I cannot leave the
> .text space at 0xFE00000. So I would prefer the IMMR be located at
> 0xF0000000 and flash be at 0xE0000000, this would leave room for future
> expansion <maybe up to 256M>, if this is even related to early startup.

Even if you boot high you  can  easily  adjust  for  different  flash
sizes. This hase been done with other boards before. Just look around
a bit. Of course everything is much easier if you boot low.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A conservative is a man with two perfectly good legs  who  has  never
learned to walk.                              - Franklin D. Roosevelt
