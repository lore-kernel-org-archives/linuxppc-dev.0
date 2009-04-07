Return-Path: <wg@denx.de>
Message-Id: <20090407082052.477328750@denx.de>
Date: Tue, 07 Apr 2009 10:20:52 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series makes the I2C bus speed configurable by using the
I2C node property "clock-frequency". If the property is not defined,
the old fixed clock settings will be used for backward compatibility.
The property "fsl,preserve-clocking" allows to inherit the settings
from the bootloader. Furthermore, it does some cleanup and uses the
new bindings for the Socrates board:

  i2c: i2c-mpc: various coding style fixes
  i2c: i2c-mpc: use dev based printout function
  i2c: i2c-mpc: make I2C bus speed configurable
  powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
  powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board

Ben, could you please consider this patch series for inclusion into
2.6.30.

TIA,

Wolfgang.
 
