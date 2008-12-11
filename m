Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id AAF89DDFC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Dec 2008 02:41:15 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LAnf5-0001H5-Qu
	for linuxppc-embedded@ozlabs.org; Thu, 11 Dec 2008 07:41:11 -0800
Message-ID: <20957894.post@talk.nabble.com>
Date: Thu, 11 Dec 2008 07:41:11 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P update to kernel 2.6 fails
In-Reply-To: <20081210231347.GA8458@ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <493ADC3B.2040505@ee.ethz.ch> <1149420832@web.de>
	<20081210231347.GA8458@ee.ethz.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


You have better to use EDK 9.1.=20
I tried to use EDK 10.1 for the xupv2p and I used the board defintion file
from=20
  https://wiki.ittc.ku.edu/ittc/Eecs388#Tool_Repository .=20
Linux 2.6 booted correctly, but I failed to get the Ethernet working.

So I used EDK 9.1 to generate the device tree. Now I have linux 2.6 on my
xupv2p, with root file system=20
on a remote host (nfs boot).
I still have a problem, I didn't succeed to access the flash disk (pbs with
sysace driver).

If you want more precise informations, I can help you.

Good luck :)




Jan M=C3=BCller wrote:
>=20
> Hi,
>=20
> Thanks a lot for the answers!
>=20
> Now I don't feel so alone anymore...
>=20
> I finally got it to work. The problem was simple: I'm using an
> uart pcore from openpcores. And this hardware requires some
> changes to the ns16550 kernel driver... With those changes,
> everything goes well! I'm happy about that.. ;-)
>=20
> But... since everything seems to work now with EDK 9.1 I try to
> use my XUP-board with the EDK 10.1
>=20
> In EDK 10.1 there is no board definition file for my XUPV2P.
> Right now I use the board file from:
>=20
>   https://wiki.ittc.ku.edu/ittc/Eecs388#Tool_Repository
>=20
> Now I got even stranger bahaviour than before. When ever I try
> to boot into a linux kernel, some arbitrary boot parameters seem
> to appear. Like:
>=20
> =09Loading from 0x00004000
> =09[...]
>=20
> And after those messages the system hangs. (the real messages
> vary from time to time)
>=20
> I have to say that for the MemoryTestApp there seems to be no
> problem.  It runs like a charm..
>=20
> So now I'm wondering if anyone has a board definition file
> usable for the linux kernel on the XUPV2P??
>=20
> Thanks a lot for any hint!
>=20
> Kind regards,
> Jan
>=20
> On Wed, Dec 10, 2008 at 11:05:13 +0100, Joachim Meyer wrote:
>> Hi
>>=20
>> I was setting up linux for teh XUP a few month ago. Both, older Kernels
>> (with ppc and xparameters_ml300.h file) and new ones (with powerpc and
>> device-tree) from the Xilinx git server worked fine for me, so yes, it
>> should work.
>> For more help you should say, what exactly you are doing, but maybe you
>> have already found your error.
>> Cheers,
>> Joachim
>> ____________________________________________________________________
>> Psssst! Schon vom neuen WEB.DE MultiMessenger geh=C3=B6rt?=20
>> Der kann`s mit allen: http://www.produkte.web.de/messenger/?did=3D3123
>>=20
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/XUPV2P-update-to-kernel=
-2.6-fails-tp20874170p20957894.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
