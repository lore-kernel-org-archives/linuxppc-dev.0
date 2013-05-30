Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] clk/mpc85xx: Update the compatible string
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130530192143.4470.23214@quantum>
Date: Thu, 30 May 2013 14:26:38 -0500
Message-Id: <17C23704-7017-427C-A00F-CEFA6247D65D@kernel.crashing.org>
References: <1369210939-25087-1-git-send-email-Yuantian.Tang@freescale.com>
 <20130530185732.4470.91176@quantum> <20130530192143.4470.23214@quantum>
To: Mike Turquette <mturquette@linaro.org>
Cc: Yuantian.Tang@freescale.com, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 30, 2013, at 2:21 PM, Mike Turquette wrote:

> Quoting Mike Turquette (2013-05-30 11:57:32)
>> Quoting Yuantian.Tang@freescale.com (2013-05-22 01:22:19)
>>> From: Tang Yuantian <yuantian.tang@freescale.com>
>>>=20
>>> The compatible string of clock is changed from *-2 to *-2.0
>>> on chassis 2. So updated it accordingly.
>>>=20
>>> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
>>=20
>> Taken into clk-next.
>>=20
>=20
> One small nitpick.  I updated the $SUBJECT to:
>=20
> clk: mpc85xx: Update the compatible string
>=20
> The difference being "clk: mpc85xx:" versus "clk/mpc85xx:".  Please =
use
> the former format in the future.
>=20
> Thanks,
> Mike

Mike,

If clk-ppc-corenet.c went into v3.10, than I think this fix is needed =
there and shouldn't wait til v3.11

- k=
