Return-Path: <wg@grandegger.com>
Message-ID: <49D31A5D.8030204@grandegger.com>
Date: Wed, 01 Apr 2009 09:40:13 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
References: <20090331124338.531903515@denx.de>
	<20090331124348.330571158@denx.de>
	<20090331230626.GB23304@yookeroo.seuss>
In-Reply-To: <20090331230626.GB23304@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Mar 31, 2009 at 02:43:39PM +0200, Wolfgang Grandegger wrote:
>> The I2c node property "fsl,preserve-clocking" allows to overtake the
>> clock settings from the boot loader and avoids the hard-coded setting.
> 
> Hrm.  This is dubious.  The device tree should generally describe
> hardware, not OS/driver behaviour which is what this appears to be
> doing.  There are exceptions, but you need to justify them.

I think the purpose of this property is clear. How would you provide
that functionality instead? I suggested that a "clock-frequency = <0>"
property should do the trick but Grant preferred to be more explicit.

Wolfgang.
