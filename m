Return-Path: <jochen@scram.de>
Message-ID: <489AD363.6070608@scram.de>
Date: Thu, 07 Aug 2008 12:50:11 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] i2c-mpc: suppress I2C device probing
References: <487F20EC.9040503@grandegger.com>	<fa686aa40807171102k6f638d9dn6dca86706673fde1@mail.gmail.com>	<20080807102126.5980c761@hyperion.delvare>
	<489ACC69.5070701@grandegger.com>
In-Reply-To: <489ACC69.5070701@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

>   $ grep I2C_CLASS_HWMON *
>   i2c-cpm.c:	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
>   i2c-mpc.c:	.class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
>   i2c-ibm_iic.c:	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>   i2c-pasemi.c:	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>   i2c-mv64xxx.c:	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> 
> It would be consequent to remove them as well.

ACK for the i2c-cpm part.

Thanks,
Jochen
