Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 629EDDDEA3
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:17:45 +1100 (EST)
Date: Fri, 15 Feb 2008 21:17:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: NOR flash partitions gone
Message-ID: <20080215181743.GA30029@localhost.localdomain>
References: <47B5E3CA.5050208@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47B5E3CA.5050208@pikatech.com>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 02:11:06PM -0500, Sean MacLennan wrote:
> I did a git pull of Josh's for-2.6.25 tree. Now the NOR partitions are 
> no longer setup.
> 
> 				nor_flash@0,0 {
> 					compatible = "amd,s29gl032a", "cfi-flash";
> 					bank-width = <2>;
> 					reg = <0 0 400000>;
> 					#address-cells = <1>;
> 					#size-cells = <1>;
> 					partition@300000 {
> 						label = "fpga";
> 						reg = <300000 40000>;
> 					};
> 					partition@340000 {
> 						label = "env";
> 						reg = <340000 40000>;
> 					};
> 					partition@380000 {
> 						label = "u-boot";
> 						reg = <380000 80000>;
> 					};
> 				};
> 
> 
> 
> It still detects the chip, it just doesn't configure the partitions. Any 
> ideas?

Probably CONFIG_MTD_OF_PARTS is not set?

Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
