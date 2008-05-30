Return-Path: <wg@grandegger.com>
Message-ID: <48404144.5010908@grandegger.com>
Date: Fri, 30 May 2008 20:02:44 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/4] [POWERPC] 85xx: support for the TQM8548 module	using
	the big Flash
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<1212130188-28835-3-git-send-email-wg@grandegger.com>
	<20080530122813.GA13407@polina.dev.rtsoft.ru>
In-Reply-To: <20080530122813.GA13407@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Fri, May 30, 2008 at 08:49:46AM +0200, Wolfgang Grandegger wrote:
>> Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
>> memory and therefore a modified memory map is required and setup by
>> the board loader. This patch adds an appropriate DTS file.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
> [...]
>> +/* NAND support must be enabled in U-Boot before Linux can use it
> 
> nand/fsl_upm.c can detect this in run-time. That is, if BRx/ORx aren't
> configured, fsl_upm_find() will return ENODEV/ENOENT/EINVAL, depending
> on what exactly is mis-configured.

Ah, I saw that and I could test UPBx configuration for the CAN as well.

Wolfgang.
