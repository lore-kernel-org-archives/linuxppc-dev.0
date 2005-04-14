Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 2CCDA67A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 23:04:06 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Date: Thu, 14 Apr 2005 15:34:10 +0200
References: <1628E43D99629C46988BE46087A3FBB9205B50@ep-01.EmbeddedPlanet.local>
In-Reply-To: <1628E43D99629C46988BE46087A3FBB9205B50@ep-01.EmbeddedPlanet.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504141534.10883.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Steven,

thank you for your answer.


> The selection of the BRGs is hard coded last time I checked.  When you
> add SMC1 and SMC2 it may use the wrong BRG for SCC1.  Check the BRG
> registers, the cmx_smr register and cmx_scr register and make sure
> everything matches up. 

But this original code seems to be ok.

static int rs_brg_map[] = {
	6,	/* BRG7 for SMC1 */
	7,	/* BRG8 for SMC2 */
	0,	/* BRG1 for SCC1 */
	1,	/* BRG2 for SCC2 */
	2,	/* BRG3 for SCC3 */
};


	/* Wire BRG7 to SMC1 and BRG8 to SMC2 */
	immap->im_cpmux.cmx_smr = 0x11;

Best regards
Marco
