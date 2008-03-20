Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 24298DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 18:48:46 +1100 (EST)
Message-ID: <47E216DA.8080602@matrix-vision.de>
Date: Thu, 20 Mar 2008 08:48:42 +0100
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Re: simple MPC5200B system
References: <47DF821B.6090600@matrix-vision.de>	<20080320001445.C03DD24A8B@gemini.denx.de>
	<20080320002149.GD19616@localhost.localdomain>
In-Reply-To: <20080320002149.GD19616@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson schrieb:
> On Thu, Mar 20, 2008 at 01:14:45AM +0100, Wolfgang Denk wrote:
>> In message <47DF821B.6090600@matrix-vision.de> you wrote:
>>> I've pulled the latest git and built a mpc5200_simple system with a=20
>>> minimal dts.
>>> There's not a single char put on the console ....
>> You did build your device tree with "-b 0", didn't you?
>=20
> Ugh.. I really need to fix dtc to pick the default boot cpu value more
> sensibly, don't I.
>=20

I didn't specify "-b 0". This shouldn't be neccessary on a single=20
processor system ! After all it's an option ... "0" should be default.

-->"./dtc -I dts -O dtb -o /mnt/tftpboot/mvbc.dtb -S 8192 dts/mvbc.dts"

The system is running fine (please see discussions with Grant).


regards,
Andr=E9 Schwarz

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
