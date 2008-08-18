Return-Path: <galak@kernel.crashing.org>
Message-Id: <56E8B13B-11C1-4CCD-AFB8-F6D534DBBF07@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <48A7E68D.8090405@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: 85xx: TQM8548: DTS file fixes and cleanup
Date: Mon, 18 Aug 2008 10:29:52 -0500
References: <48A7E68D.8090405@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2008, at 3:51 AM, Wolfgang Grandegger wrote:

> Due to the missing compatible property for the SOC, the MPC I2C  
> buses are
> not found any more. This patch fixes this issue. Furthermore it  
> corrects
> the name of the SOC node and adds the missing I2C node for the RTC.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    8 +++++++-
> arch/powerpc/boot/dts/tqm8548.dts          |    3 ++-
> 2 files changed, 9 insertions(+), 2 deletions(-)

applied.

- k
