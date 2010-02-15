Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265813711-16794-1-git-send-email-wg@grandegger.com>
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Feb 2010 12:34:35 -0700
Message-ID: <fa686aa41002151134pfbbe66fm978cfa0215446d51@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] i2c-mpc: add support for the Freescale MPC512x and
	other fixes
To: Wolfgang Grandegger <wg@grandegger.com>, Ben Dooks <ben-linux@fluff.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben D.,

These 4 patches are totally fine.  Do you want to pick them up, or
should I take them through the PowerPC tree?

Cheers,
g.

On Wed, Feb 10, 2010 at 7:55 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> From: Wolfgang Grandegger <wg@denx.de>
>
> This patch series adds support for the MPC512x from Freescale to the
> i2c-mpc driver. At that occasion, issues with =A0__devinit[data] have
> been fixed and the doc of the FSL I2C dts bindings updated. It has
> been tested on a MPC5121ADS, TQM5200 and TQM8560 board
>
> Changes since v1:
>
> - use macro MPC_I2C_CLOCK_PRESERVE/SAFE for the special clock settings.
> - document the special DTS node "fsl,mpc5121-i2c-ctrl".
> - update and correct the Kconfig help.
> - some other minor fixes as suggested by Wolfram.
>
> Changes since v2:
>
> - use __init[data] instead of __devinit[data] for this driver.
>
> Changes since v3:
>
> - switch back to __devinit[data] as pointed out by Ben.
>
> Changes since v4:
>
> - check MPC_I2C_CLOCK_SAFE instead of "!clock" as suggested by Wolfram.
> - update MODULE_DESCRIPTION().
>
> Changes since v5 (suggested by Grant Likely):
>
> - various correctings for labling initialization functions and data
> =A0(this is tricky because section mismatches are not always obvious).
> - add a separate patch for renaming the setclock into setup functions.
> - correct the doc of the I2C bindings, e.g. don't mention the legacy
> =A0clock setting and remove obsolte parts.
>
> Changes since v6:
>
> - use __devinitconst for const data as suggested by Stephen Rothwell.
>
> Wolfgang
>
> Wolfgang Grandegger (4):
> =A0i2c-mpc: use __devinit[data] for initialization functions and data
> =A0i2c-mpc: rename "setclock" initialization functions to "setup"
> =A0i2c-mpc: add support for the MPC512x processors from Freescale
> =A0powerpc: doc/dts-bindings: update doc of FSL I2C bindings
>
> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 30 +++-
> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A07 +-
> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
194 +++++++++++++++---------
> =A03 files changed, 146 insertions(+), 85 deletions(-)
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
