Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18454.49097.53537.474679@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 16:27:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: build failure on efika
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My test builds for efika currently fail with this message:

FATAL: drivers/serial/mpc52xx_uart: struct of_device_id is not terminated with a NULL entry!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [sub-make] Error 2

Could you do a little patch to add the NULL entry please?

Paul.
