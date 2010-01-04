Return-Path: <wd@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH net-next 2/3] can: mscan-mpc5xxx: add support for the
	MPC521x processor
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20100104162441.GA4665@pengutronix.de>
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>
	<1262420274-16586-2-git-send-email-wg@grandegger.com>
	<1262420274-16586-3-git-send-email-wg@grandegger.com>
	<20100102135734.GC2239@pengutronix.de>
	<4B3F6F6B.5070004@grandegger.com>
	<20100104162441.GA4665@pengutronix.de>
Date: Mon, 04 Jan 2010 20:40:27 +0100
Message-Id: <20100104194027.CB2053F6FD@gemini.denx.de>
Cc: Netdev@vger.kernel.org, Devicetree-discuss@lists.ozlabs.org,
	Socketcan-core@lists.berlios.de, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfram,

in message <20100104162441.GA4665@pengutronix.de> you wrote:
> 
> One further note: I couldn't spot any code handling Rev1 of the MPC5121? Do you
> plan to add such code? If not, we should at least put a comment that it is
> missing. The binding documentation should be updated as well, as you can't use
> all options on such revisions.

We only support MPC512x Rev. 2 (and later). This is also true for
other parts of the mainline kernel code - see for example trhe NAND
driver.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Include the success of others in your dreams for your own success.
