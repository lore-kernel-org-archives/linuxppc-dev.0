Return-Path: <jochen@scram.de>
Message-ID: <4867FB00.5010306@scram.de>
Date: Sun, 29 Jun 2008 23:13:36 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Convert i2c-mpc from a platform driver into a of_platform
	driver, V2
References: <20080629164443.4381.71902.stgit@terra>
In-Reply-To: <20080629164443.4381.71902.stgit@terra>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

> This version adds of_find_i2c_device_by_node() which is needed by ASOC drivers.

Cool. I was about to do something similar (of_get_adapter_nr_by_node).

IMHO, the patch should be splitted into the addition of of_find_i2c_device_by_node()
and the actual patch of i2c-mpc.

Thanks,
Jochen
