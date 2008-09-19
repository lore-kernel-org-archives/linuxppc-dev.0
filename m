Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 3235FDDEE3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 21:31:17 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so570614fga.39
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 04:31:15 -0700 (PDT)
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH v2] bootwrapper: support u-boot multi component images
References: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
	<20080919112602.291410@gmx.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 19 Sep 2008 13:31:12 +0200
In-Reply-To: <20080919112602.291410@gmx.net> (Gerhard Pircher's message of
	"Fri\, 19 Sep 2008 13\:26\:02 +0200")
Message-ID: <87d4j01if3.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Gerhard" == Gerhard Pircher <gerhard_pircher@gmx.net> writes:

Hi,

 >> Support uImage.<platform>, which are U-Boot multi component images
 >> containing a kernel, dtb and possibly an initrd.
 Gerhard> Just out of interest: Do you intend to replace the code for building
 Gerhard> cuImage.<platform> (zImage target) with this new build target?

No, they are for different use cases. cuImages are interesting when
you cannot upgrade uboot to add device tree support and you want to
use a new kernel - uImage.% is interesting when you want to use device
trees but you want the simplicity of having a single file (And you
acknowledge the fact that the device tree as it is today is pretty much
kernel version dependent so it makes most sense to keep them in sync).

-- 
Bye, Peter Korsgaard
