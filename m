Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18330.32110.449914.354218@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jan 2008 11:23:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH v3] create modalias file in sysfs for bus of_platform
In-Reply-To: <20080122190939.GA14124@aepfle.de>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
	<20080122190939.GA14124@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
> of modules. modalias files are already present for many other bus types.

This one causes various oopses on boot for me, both on a dual G5 and
on a tibook.

Paul.
