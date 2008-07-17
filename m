Return-Path: <wg@grandegger.com>
Message-ID: <487F2157.90604@grandegger.com>
Date: Thu, 17 Jul 2008 12:39:19 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Support for DS75 thermal sensor
References: <487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
	<487DBB92.1070100@grandegger.com>
	<20080716113311.384d211e@hyperion.delvare>
	<487DC457.6000103@grandegger.com>
	<20080716121059.2dbbfebe@hyperion.delvare>
	<20080716140807.GB24045@secretlab.ca>
	<9e4733910807160718y580292abi5f44a05f466fd358@mail.gmail.com>
	<20080716162942.6fcb526d@hyperion.delvare>
	<487EF54C.5020007@grandegger.com>
	<20080717073312.GB30474@secretlab.ca>
In-Reply-To: <20080717073312.GB30474@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org,
	Alan Clucas <alanc@pipstechnology.co.uk>,
	Detlev Zundel <dzu@denx.de>, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Jul 17, 2008 at 09:31:24AM +0200, Wolfgang Grandegger wrote:
>> Jean Delvare wrote:
>>> On Wed, 16 Jul 2008 10:18:26 -0400, Jon Smirl wrote:
>>>> I've found this thread now. Why can't we totally remove probing from
>>>> i2c-mpc? These are embedded systems, not open boxes like a PC. If a
>>>> i2c client hasn't been converted to the new model yet, convert it
>>>> before deploying with the new i2c-mpc driver.  It's not very hard to
>>>> convert the client drivers.
>>> I tend to agree. And the number of unconverted drivers is getting very
>>> low these days. Only 2 RTC drivers are left, and by the end of the day,
>>> almost all hwmon drivers will be converted as well.
>> Thinking more about it I also prefer removing the I2C_CLASS_HWMON flag  
>> completely. It just affects HWMON devices anyhow and if there is still  
>> an old style driver around, it should be converted.
> 
> I'm cool with that.

Good, just sent a new patch.

Wolfgang.
