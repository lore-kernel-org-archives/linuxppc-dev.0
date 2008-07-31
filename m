Return-Path: <timur@freescale.com>
Message-ID: <4891FC3A.7040609@freescale.com>
Date: Thu, 31 Jul 2008 12:54:02 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com>
	<48899736.8020400@grandegger.com>	
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>	
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>	
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>	
	<20080727012722.GH12191@secretlab.ca>	
	<4891A744.6060005@grandegger.com>	
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>	
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
In-Reply-To: <fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> static const struct of_device_id mpc_i2c_of_match[] = {
> 	{.compatible = "fsl,mpc5200b-i2c", .data = fsl_i2c_mpc5200b_set_freq, },
> 	{.compatible = "fsl,mpc5200-i2c", .data = fsl_i2c_mpc5200_set_freq, },
> 	{.compatible = "fsl,mpc8260-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
> 	{.compatible = "fsl,mpc8349-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
> 	{.compatible = "fsl,mpc8540-i2c", .data = fsl_i2c_mpc8xxx_set_freq, },
> 	{.compatible = "fsl,mpc8543-i2c", .data = fsl_i2c_mpc8xxx_div2_set_freq, },
> 	{.compatible = "fsl,mpc8544-i2c", .data = fsl_i2c_mpc8xxx_div3_set_freq, },

So we need to update this table every time there's a new SOC?  All 83xx, 85xx,
and 86xx SOCs use the same table.  I'd prefer an implementation that does need a
specific entry for each variant of 8[356]xx.

-- 
Timur Tabi
Linux kernel developer at Freescale
