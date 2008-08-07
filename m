Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40808070733q6304707p5015ec94cbecfc0f@mail.gmail.com>
Date: Thu, 7 Aug 2008 08:33:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-mpc: suppress I2C device probing
In-Reply-To: <20080807130717.56694249@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <487F20EC.9040503@grandegger.com>
	<fa686aa40807171102k6f638d9dn6dca86706673fde1@mail.gmail.com>
	<20080807102126.5980c761@hyperion.delvare>
	<489ACC69.5070701@grandegger.com> <489AD363.6070608@scram.de>
	<20080807130717.56694249@hyperion.delvare>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 7, 2008 at 5:07 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 07 Aug 2008 12:50:11 +0200, Jochen Friedrich wrote:
>> Hi Wolfgang,
>>
>> >   $ grep I2C_CLASS_HWMON *
>> >   i2c-cpm.c:        .class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
>> >   i2c-mpc.c:        .class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
>> >   i2c-ibm_iic.c:    adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>> >   i2c-pasemi.c:     smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>> >   i2c-mv64xxx.c:    drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>> >
>> > It would be consequent to remove them as well.
>>
>> ACK for the i2c-cpm part.
>
> No objection on my side. It's really up to each platform to choose the
> way they want to handle i2c device creation, and stick to it.
>
> As I understand it, the removal of the adapter class needs to be
> synchronized with platform code changes. Thus it might make sense to
> push these through their respective arch trees, rather than the i2c
> tree.

All right, I'm happy to pick these patches up if nobody objects.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
