Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807160547q28f49865o11ec878d98987329@mail.gmail.com>
Date: Wed, 16 Jul 2008 08:47:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
In-Reply-To: <487DD1BD.8040701@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <487DD1BD.8040701@grandegger.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/16/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Currently, the I2C buses are probed for HWMON I2C devices, which might
>  not be acceptable in same cases. This patch makes device probing
>  configurable through the property "probe" of the FDT I2C device node:

All this patch seems to be doing is removing class I2C_CLASS_HWMON via
a device tree flag, PROBE.

Why do you need to do this? The OF conversion patch that is working
its way through the system lets you put the address of the device into
the device tree node. Probing shouldn't be necessary at all.

-- 
Jon Smirl
jonsmirl@gmail.com
