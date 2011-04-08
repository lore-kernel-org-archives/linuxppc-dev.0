Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8282B6F82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 18:24:50 +1000 (EST)
Received: by pzk4 with SMTP id 4so1894747pzk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2011 01:24:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Fri, 8 Apr 2011 10:24:47 +0200
Message-ID: <BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Linux PPC <linuxppc-dev@ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Prabhakar,

On Fri, Apr 8, 2011 at 5:44 AM, Kushwaha Prabhakar-B32579
<B32579@freescale.com> wrote:
>> -----Original Message-----
>> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
>> Sent: Thursday, April 07, 2011 10:23 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Tejun Heo;
>> Jeff Garzik
>> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>>
>> On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
>> <B32579@freescale.com> wrote:
>> > Can you please check p2020rdb.dts for IDSEL entries for pci0/1 node?
>> >
>> > In order to work in legacy mode, IDSEL entries are required.
>> >
>> No, the p1020rdb and p2020rdb do not have the IDSEL entries:
>> What would the correct IDSEL entries be?
>
> For legacy interrupt to work IDSEL values are required.. please find the =
correct IDSEL values for pci0/1.
>
> =A0 =A0 =A0 =A0pci0: pcie@ffe09000 {
> ...
> Please try with this.. I am in process of pushing these IDSEL values to u=
pstream.
>

Do you have these for P1020RDB  as well? I found a P1020RDB board that
has the CE10 errata fixed, so IRQ0 is properly pulled up.


Regards,
--=20
Leon
