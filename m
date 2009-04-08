Return-Path: <galak@kernel.crashing.org>
Message-Id: <FD9A70C0-D4D0-4867-B1C1-3D6CFC5C0E93@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <20090407082231.646648985@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3 4/5] powerpc: i2c-mpc: document new FSL I2C bindings
	and cleanup
Date: Wed, 8 Apr 2009 00:13:36 -0500
References: <20090407082052.477328750@denx.de>
	<20090407082231.646648985@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:

> This patch documents the new bindings for the MPC I2C bus driver.
> Furthermore, it removes obsolete FSL device related definitions
> for I2C.
> It should go through the appropriate PowerPC maintainer(s) hands.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/i2c.txt |   46 +++++++++++++++ 
> +---------
> include/linux/fsl_devices.h                    |    4 --
> 2 files changed, 31 insertions(+), 19 deletions(-)

applied to merge

- k
