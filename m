Return-Path: <jochen@scram.de>
Message-ID: <487E0A3E.80706@scram.de>
Date: Wed, 16 Jul 2008 16:48:30 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
References: <487DD1BD.8040701@grandegger.com>
	<20080716142436.GD24045@secretlab.ca>
In-Reply-To: <20080716142436.GD24045@secretlab.ca>
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

Hi Grant,

> On Wed, Jul 16, 2008 at 12:47:25PM +0200, Wolfgang Grandegger wrote:
>> Currently, the I2C buses are probed for HWMON I2C devices, which might
>> not be acceptable in same cases. This patch makes device probing
>> configurable through the property "probe" of the FDT I2C device node:
>>
>>       i2c@3000 {
>>            ...
>>            compatible = "fsl-i2c";
>>            probe;
>> 	    ...
>>        };
> 
> You need to add documentation to booting-without-of.txt about what the
> 'probe' property means.  Also, 'probe' is a pretty generic term being
> used in an i2c specific context.  Can you prefix it with i2c or
> something to protect the namespace?  'i2c-probe' perhaps?

In i2c-cpm, I currently use the property "linux,i2c-class" to set the
i2c class directly as documented in dts-bindings/fsl/cpm_qe/cpm/i2c.txt.

We should agree on *one* method to set the i2c class.

Thanks,
Jochen
