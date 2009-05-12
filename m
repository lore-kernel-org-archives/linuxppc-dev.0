Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og112.obsmtp.com (exprod7og112.obsmtp.com [64.18.2.177])
	by ozlabs.org (Postfix) with SMTP id DBCDCDDFA2
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 06:46:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Having a hell of a time with spidev and spi_mpc8313
Date: Tue, 12 May 2009 13:39:33 -0700
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B60A65C253@SJEXCH03.ds.jdsu.net>
In-Reply-To: <8A71B368A89016469F72CD08050AD33402D5760B@maui.asicdesigners.com>
References: <8A71B368A89016469F72CD08050AD33402D5760B@maui.asicdesigners.com>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a device that I need to access via SPI.  I am running 2.6.27 on
the MPC8313.  I have configured the kernel with both CONFIG_SPI_MPC83xx
and CONFIG_SPI_SPIDEV.  I hand made a character device with a major
number of 153 and a minor number of 0.

I need some guidance on how to make the SPI slave table, and where to
put the code that connects this to my device file.  Also, I am not
seeing the "%s: MPC83xx SPI Controller driver" print out at boot up, is
this a problem?

- Joaquin Luna
