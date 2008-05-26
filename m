Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 81974DDFDF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 May 2008 20:08:46 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K0ZdC-00054L-1S
	for linuxppc-embedded@ozlabs.org; Mon, 26 May 2008 03:08:42 -0700
Message-ID: <17469128.post@talk.nabble.com>
Date: Mon, 26 May 2008 03:08:42 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: mmap problem in device driver and application program.
In-Reply-To: <BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <BAY138-W55519F961B3A01D0B8A167B2D00@phx.gbl>
	<1210266109.3755.8.camel@localhost.localdomain>
	<BAY138-W36C7249F532D111A1DC508B2D00@phx.gbl>
	<1210366552.3755.21.camel@localhost.localdomain>
	<BAY138-W368A781D323F0E5E4D0BF3B2CF0@phx.gbl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi ...

I guess you can remap the memory region outside the kernel control and then
convert it into page and use it into your mmap implementation in the driver
else it is easy to use the same in application by opening /dev/mmap file=20

regards=20
Misbah <><


mliu wrote:
>=20
>=20
> Dear Dave,
>> If you are using memory that is not under the kernel's memory management=
>
>> you will need to use something other than remap_pfn_range.>=20
> Happenly and unfortunately we are using the memory space out of the
> control from the kernel. We have 2GB memory on the board and only 64(or
> 32) MB is reserved for the kernel. The rest large space is for the data
> buffering or LUT use. In my question, the LUT memory is located in the
> rest part rather than the kernel memory area.=20
> =20
> Any more suggestion on how to mmap this LUT area? Any idea will be
> valuable for a beginner like me. Thanks in advance.=20
> =20
> BR
> Ming
> _________________________________________________________________
> =E6=96=B0=E5=B9=B4=E6=8D=A2=E6=96=B0=E9=A2=9C=EF=BC=8C=E5=BF=AB=E6=9D=A5=
=E5=A6=86=E6=89=AE=E8=87=AA=E5=B7=B1=E7=9A=84MSN=E7=BB=99=E5=BF=83=E4=BB=AA=
=E7=9A=84TA=E4=B8=80=E4=B8=AA=E6=83=8A=E5=96=9C=EF=BC=81
> http://im.live.cn/emoticons/?ID=3D18
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=20
View this message in context: http://www.nabble.com/mmap-problem-in-device-=
driver-and-application-program.-tp17130303p17469128.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
