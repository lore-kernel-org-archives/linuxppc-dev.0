Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 6A11DDF5BF
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:30:28 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so61864wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:30:26 -0700 (PDT)
Subject: Re: [RFC][PATCH] I2C driver
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <48AD9610.8090205@harris.com>
References: <48AD9610.8090205@harris.com>
Content-Type: text/plain
Date: Thu, 21 Aug 2008 12:30:02 -0400
Message-Id: <1219336202.26429.55.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 12:21 -0400, Steven A. Falco wrote:
> The following patch enables building the I2C driver for 4xx chips.
> Tested on a Sequoia board.  Comments invited.
> 
> Signed-off-by: Steven A. Falco <sfalco@harris.com>
> ---
>  drivers/i2c/busses/Kconfig      |    7 +++++++
>  drivers/i2c/busses/i2c-ibm_of.c |    5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)

That file doesn't even exist in the mainline kernel:

[jwboyer@yoda linux-2.6]$ find drivers/i2c/ -name *ibm*
drivers/i2c/busses/i2c-ibm_iic.c
drivers/i2c/busses/i2c-ibm_iic.h
[jwboyer@yoda linux-2.6]$ 

josh
