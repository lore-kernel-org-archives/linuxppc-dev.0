Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807160711v29c9fc41k21e084b317151e85@mail.gmail.com>
Date: Wed, 16 Jul 2008 10:11:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
In-Reply-To: <487DF304.7090205@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <487DD1BD.8040701@grandegger.com>
	<9e4733910807160547q28f49865o11ec878d98987329@mail.gmail.com>
	<487DF304.7090205@grandegger.com>
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
> Jon Smirl wrote:
>
> > On 7/16/08, Wolfgang Grandegger <wg@grandegger.com> wrote:
> >
> > > Currently, the I2C buses are probed for HWMON I2C devices, which might
> > >  not be acceptable in same cases. This patch makes device probing
> > >  configurable through the property "probe" of the FDT I2C device node:
> > >
> >
> > All this patch seems to be doing is removing class I2C_CLASS_HWMON via
> > a device tree flag, PROBE.
> >
>
>  Yep.
>
>
> > Why do you need to do this? The OF conversion patch that is working
> > its way through the system lets you put the address of the device into
> > the device tree node. Probing shouldn't be necessary at all.
> >
>
>  Currently I2C_CLASS_HWMON is used for all I2C adapters and therefore
> probing is done even with a proper I2C node defined in the DTS file. That's
> what the patch is fixing leaving the possibility to (re-)enable legacy
> probing.

Shouldn't we just remove I2C_CLASS_HWMON since everything can now be
explicitly described in the device tree? What is an example of a case
where we still need to probe?

>
>  For some more details you may want to have a look to Jean's mail on that
> subject:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060012.html.
>
>  Wolfgang.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
