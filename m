Return-Path: <wg@grandegger.com>
Message-ID: <484007B6.2070300@grandegger.com>
Date: Fri, 30 May 2008 15:57:10 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [NAND] driver extension to support NAND on TQM85xx modules
References: <1212129392-27589-1-git-send-email-wg@grandegger.com>
	<8B8CFD8C-8F18-4548-A07B-5748BAD1ACEA@kernel.crashing.org>
In-Reply-To: <8B8CFD8C-8F18-4548-A07B-5748BAD1ACEA@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On May 30, 2008, at 1:36 AM, Wolfgang Grandegger wrote:
> 
>> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
>> support for the TQM85xx modules. Unfortunately, the hardware does
>> not support the R/B pins of the NAND chip and therefore the specified
>> maximum delay time must used. It therefore re-introduces the chip-delay
>> property.
>>
>> Note: this patch is based on a patch Anton Vorontsov posted to this list:
>>      See http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
>>      It should show up mainstream soon.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>> drivers/mtd/nand/Kconfig   |    2 +-
>> drivers/mtd/nand/fsl_upm.c |   30 +++++++++++++++++++++---------
>> include/linux/of_gpio.h    |    2 +-
>> 3 files changed, 23 insertions(+), 11 deletions(-)
> 
> You really need to CC the MTD list as this should go via them.  Also
> you're adding a new property and there should be updates to
> booting-w-o-f for it.

OK. There are various patches pending for booting-w-o-f including
"[PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU,
FSL UPM and GPIO LEDs bindings" from Anton. What tree should the patches
for NAND and 85xx be based on for kernel inclusion?

Wolfgang.
