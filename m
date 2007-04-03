Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1EC7EDDE46
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:28:49 +1000 (EST)
Date: Tue, 3 Apr 2007 14:28:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] add modalias file for of_devices to sysfs
Message-ID: <20070403122859.GA19547@aepfle.de>
References: <20070402124547.GA11415@aepfle.de> <461137B8.9000404@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <461137B8.9000404@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 02, Sylvain Munaut wrote:

> In my patch to "unify" the uevent generation, I've made a separate
> function that generate
> the modalias string especially so that we don't repeat the same piece of
> code twice.
> 
> It's prototype is :
> 
> +static ssize_t of_device_get_modalias(struct of_device *ofdev,
> +					char *str, ssize_t len)
> 
> So the modalias_show can be shortened to
> 
> return of_device_get_modalias(to_of_device(dev), buf, PAGE_SIZE);

macio_sysfs needs to be adapted as well.
Your version does not append a newline to the moalias content.
