Return-Path: <wg@grandegger.com>
Message-ID: <4B5E0523.9080701@grandegger.com>
Date: Mon, 25 Jan 2010 21:54:59 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors	from
	Freescale
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
	<20100125115211.GA5257@pengutronix.de>
	<4B5D894C.4090001@grandegger.com>
	<20100125151509.GD5257@pengutronix.de>
	<4B5DE3FB.10505@grandegger.com>
	<20100125204833.GB9693@pengutronix.de>
In-Reply-To: <20100125204833.GB9693@pengutronix.de>
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

Wolfram Sang wrote:
>> overkill to me. I will have a closer look, though. At a minimum I will
>> replace "-1" with "MPC_I2C_PRESERVE_CLOCK".
> 
> Might be also an idea to define it with ~0 (clock is still unsigned). If
> possible, the code checking for those two cases (0 and "-1") should be close
> together. That could be a compromise until more quirks are needed ;)

I just sent v2. Hope it's OK now.

Wolfgang.
