Return-Path: <wd@denx.de>
To: "Amir Bukhari" <Bukhari@fzi.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Porting new MPC5200 based Board to linux kernel 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Apr 2006 16:39:17 +0200."
	<EE3E34EBE104B24DA5DF5DBC1EA998D528801E@loretta.fzi.de>
Date: Fri, 07 Apr 2006 00:48:56 +0200
Sender: wd@denx.de
Message-Id: <20060406224856.BA993352671@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EE3E34EBE104B24DA5DF5DBC1EA998D528801E@loretta.fzi.de> you wrote:
> We have a MEN mpc5200 base board and we want to get linux running on it.
> MEN has a bios and can load linux kernel and passing to parameters. I have
> tried to configure kernel manualy but without success. MEN bios load kernel,
> but nothing happend after that, I don't see anything on console.

Is this by any chance a PP01 board? If yes, then see our
linuxppc_2_4_devel kernel tree which supports this board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...and the fully armed nuclear warheads, are, of  course,  merely  a
courtesy detail."
