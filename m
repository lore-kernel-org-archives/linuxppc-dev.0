Return-Path: <wg@grandegger.com>
Message-ID: <49D31856.9060808@grandegger.com>
Date: Wed, 01 Apr 2009 09:31:34 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Subject: Re: [PATCH 6/8] --- arch/powerpc/boot/dts/socrates.dts | 9	+++++++--
	1 file changed, 7 insertions(+), 2 deletions(-)
References: <20090331123727.853787299@denx.de>
	<20090331124036.057237866@denx.de>
	<20090331230451.GA23304@yookeroo.seuss>
In-Reply-To: <20090331230451.GA23304@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

this patch went out by mistake, sorry.

David Gibson wrote:
> On Tue, Mar 31, 2009 at 02:37:33PM +0200, Wolfgang Grandegger wrote:
>> Index: linux-2.6/arch/powerpc/boot/dts/socrates.dts
>> ===================================================================
>> --- linux-2.6.orig/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:24:38.078719288 +0200
>> +++ linux-2.6/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:47:56.986720719 +0200
>> @@ -52,6 +52,7 @@
>>  	soc8544@e0000000 {
>>  		#address-cells = <1>;
>>  		#size-cells = <1>;
>> +		device_type = "soc";
> 
> You should not be adding device_type to a new board's dts.  You
> *especially* shouldn't be doing that with no patch comment explaining
> why.

In the final patch I have removed the device_type = "soc", but it makes
trouble as some mpc85xx rely on it. Removing it would also break U-Boot
compatibility. Is it worth that? The issue is discussed on the thread
http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070020.html.

Wolfgang.
