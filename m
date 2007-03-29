Return-Path: <jcrigby@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id D5542DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 07:20:21 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so345967ana
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 14:20:19 -0700 (PDT)
Message-ID: <4b73d43f0703291420v620b871fp97cb34941b1e7a85@mail.gmail.com>
Date: Thu, 29 Mar 2007 15:20:19 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
Subject: publishing OF platform devices
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a question about the "right" way to publish platform
devices via of_platform_bus_probe.

On 5200 platforms it gets called from
mpc52xx_declare_of_platform_devices which is registered as the
machdep_calls init routine.

On other platforms it is called via a device_initcall

I assume the main difference between these two is one would happen
later than the other?

Also I noticed that some 83xx platforms don't call
of_platform_bus_probe at all.  Thats ok because most of those devices
are register various routines in fsl_soc.c.  The one I have not
figured out yet is spi, I don't see anyone registering mpc83xx_spi?

Any enlightenment would be appreciated

Thanks
John
