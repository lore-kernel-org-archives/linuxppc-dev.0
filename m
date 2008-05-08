Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 42CBBDDE18
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 07:31:04 +1000 (EST)
Date: Thu, 8 May 2008 23:31:01 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v5] create modalias file in sysfs for bus of_platform
Message-ID: <20080508213101.GA8848@aepfle.de>
References: <20080122142109.GA12967@aepfle.de>
	<20080122144053.GA13019@aepfle.de>
	<20080122190939.GA14124@aepfle.de>
	<18330.32110.449914.354218@cargo.ozlabs.ibm.com>
	<20080126100427.GA1162@aepfle.de>
	<20080424131600.GA15226@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080424131600.GA15226@aepfle.de>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, Olaf Hering wrote:

> Create /sys/bus/of_platform/devices/*/modalias file to allow autoloading
> of modules. modalias files are already present for many other bus types.
> This adds also a newline to the devspec files.
> 
> Also create a devspec file for mac-io devices. They were created as a side
> effect. Use correct buffer size for mac-io modalias buffer.
> 
> Tested on iBook1 and Efika.

Did anyone test this on other systems, like sparc?
