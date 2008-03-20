Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 2324FDDECF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 20:12:10 +1100 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 98AD53CC37A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:11:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 0D5D5E3C09
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:11:53 +0100 (CET)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id E3264E3C09
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:11:52 +0100 (CET)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 32B9C53E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 10:10:09 +0100 (CET)
Message-ID: <47E22A5D.5080304@matrix-vision.de>
Date: Thu, 20 Mar 2008 10:11:57 +0100
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Re: simple MPC5200B system
References: <47DF821B.6090600@matrix-vision.de>
	<20080320001445.C03DD24A8B@gemini.denx.de>
	<20080320002149.GD19616@localhost.localdomain>
	<47E216DA.8080602@matrix-vision.de>
	<20080320082035.GA23860@localhost.localdomain>
In-Reply-To: <20080320082035.GA23860@localhost.localdomain>
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
> On Thu, Mar 20, 2008 at 08:48:42AM +0100, Andr=E9 Schwarz wrote:
>> David Gibson schrieb:
>>> On Thu, Mar 20, 2008 at 01:14:45AM +0100, Wolfgang Denk wrote:
>>>> In message <47DF821B.6090600@matrix-vision.de> you wrote:
>>>>> I've pulled the latest git and built a mpc5200_simple system with a=
=20
>>>>> minimal dts.
>>>>> There's not a single char put on the console ....
>>>> You did build your device tree with "-b 0", didn't you?
>>> Ugh.. I really need to fix dtc to pick the default boot cpu value mor=
e
>>> sensibly, don't I.
>> I didn't specify "-b 0". This shouldn't be neccessary on a single proc=
essor=20
>> system ! After all it's an option ... "0" should be default.
>=20
> Should, yes.  But dtc's pretty new, and a sensible default for -b is
> one thing that isn't there.
>=20

ok - but this has not caused my (solved) problem. dtc is working fine=20
for me :-)

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
