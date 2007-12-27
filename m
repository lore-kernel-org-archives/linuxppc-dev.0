Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id F1E3EDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 03:47:11 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5095952wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 08:47:10 -0800 (PST)
Message-ID: <9e4733910712270847j35778e43i66fda3eca9dc125@mail.gmail.com>
Date: Thu, 27 Dec 2007 11:47:10 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Version 17, series to add device tree naming to i2c
In-Reply-To: <20071220044136.20091.70984.stgit@terra.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Another rework of the i2c for powerpc device tree patch. This version implements standard alias naming only on the powerpc platform and only for the device tree names. The old naming mechanism of i2c_client.name,driver_name is left in place and not changed for non-powerpc platforms. This patch is fully capable of dynamically loading the i2c modules. You can modprobe in the i2c-mpc driver and the i2c modules described in the device tree will be automatically loaded. Modules also work if compiled in.


Are there any further objections to this patch? Can it all go in
through the powerpc trees or do the i2c people want to send it on?

-- 
Jon Smirl
jonsmirl@gmail.com
