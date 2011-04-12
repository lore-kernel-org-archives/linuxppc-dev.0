Return-Path: <B10812@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3480B6F17
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 14:05:31 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>, "linuxppc-dev@ozlabs.org"
	<linuxppc-dev@ozlabs.org>
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
Date: Tue, 12 Apr 2011 04:05:19 +0000
Message-ID: <45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
References: <071A08F2C6A57E4E94D980ECA553F87417069A@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87417069A@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gupta Maneesh-B18878 <B18878@freescale.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Felix

Please find some comments inline.

Regards
Poonam

> -----Original Message-----
> From: Kushwaha Prabhakar-B32579
> Sent: Tuesday, April 12, 2011 9:26 AM
> To: Aggrwal Poonam-B10812
> Subject: FW: Problem with mini-PCI-E slot on P2020RDB
>=20
>=20
>=20
> -----Original Message-----
> From: Felix Radensky [mailto:felix@embedded-sol.com]
> Sent: Monday, April 11, 2011 7:16 PM
> To: Kushwaha Prabhakar-B32579
> Cc: Fabian Bertholm; Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan
> Vivek-B08308; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>=20
> Hi Prabhakar,
>=20
> On 04/11/2011 02:09 PM, Kushwaha Prabhakar-B32579 wrote:
> > Hi,
> >
> > Yes. It wil be applicable for all revisions.
> >
> > Regards,
> > Prabhakar
> >
>=20
> I'm sure this is applicable to all revisions, but it doesn't necessarily
> makes things work. The problem I've reported back in 2009 still exists on
> P2020RDB revC, even if I use the latest u-boot and kernel and make device
> tree changes that you've suggested.
> I've attached the boot log.
As such there is no hardware fix related to this issue between RevC to RevD=
. The solution was a software patch to resolve the issue related to IRQ0.
>=20
> On the other hand, on P1020RDB revD with the same kernel, ath9k driver
> loads fine and interrupts are arriving. However this only works with u-
> boot-2010.12.
May be you can look at http://old.nabble.com/Problem-with-mini-PCI-E-slot-o=
n-P2020RDB-td26802038.html

Felix we do not have the atheros driver for 2.6.38 and the issue is only se=
en with Atheros not sata_sil. If possible can you send the driver code if p=
ossible so that we can try reproducing it.

Regards
Poonam=20

=20
>=20
>=20
>=20
> >> -----Original Message-----
> >> From: Felix Radensky [mailto:felix@embedded-sol.com]
> >> Sent: Monday, April 11, 2011 2:10 PM
> >> To: Kushwaha Prabhakar-B32579
> >> Cc: Fabian Bertholm; Leon Woestenberg; linuxppc-dev@ozlabs.org;
> >> Mahajan Vivek-B08308; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
> >> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
> >>
> >> Hi,
> >>
> >> Assuming I have all patches in place, will this problem be resolved
> >> on earlier board revisions (before rev D) ?
> >>
> >> Felix.
> >>
> >> On 04/11/2011 12:06 PM, Kushwaha Prabhakar-B32579 wrote:
> >>> Hi Fabe,
> >>>
> >>> Yes .. P1020/P1011 RDB has same issue as of P2020RDB.
> >>>
> >>> It was because of some missing patches at u-boot and Linux.
> >>>
> >>> U-boot patch : It is already present in open source. Please use
> >>> latest code base Linux patch : I am in process of posting in open
> source.
> >> Please make mentioned changes of IDSEL.
> >>> --Prabhakar
> >>>
> >>>> -----Original Message-----
> >>>> From: Fabian Bertholm [mailto:fabeisageek@googlemail.com]
> >>>> Sent: Monday, April 11, 2011 1:53 PM
> >>>> To: Kushwaha Prabhakar-B32579
> >>>> Cc: Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan
> >>>> Vivek-B08308; Felix Radensky; Aggrwal Poonam-B10812; Gupta
> >>>> Maneesh-B18878
> >>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
> >>>>
> >>>> Hello Kushwaha Prabhakar,
> >>>>
> >>>> Our impression is that there is the same issue on the P1020/P1011
> RDB.
> >>>> Can you confirm this?
> >>>>
> >>>> Best Regards,
> >>>> Fabe
> >>>>
> >>>>
> >>>> 2011/4/8 Kushwaha Prabhakar-B32579<B32579@freescale.com>:
> >>>>>> -----Original Message-----
> >>>>>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
> >>>>>> Sent: Thursday, April 07, 2011 10:50 PM
> >>>>>> To: linuxppc-dev@ozlabs.org
> >>>>>> Cc: Kumar Gala; Mahajan Vivek-B08308; Aggrwal Poonam-B10812;
> >>>>>> Felix Radensky; Kushwaha Prabhakar-B32579
> >>>>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> On Thu, Dec 17, 2009 at 9:28 PM, Felix Radensky
> >>>>>> <felix@embedded-sol.com>
> >>>>>> wrote:
> >>>>>>> Kumar Gala wrote:
> >>>>>>>> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
> >>>>>>>>>> Thanks a lot. If I understand you correctly, the only way I
> >>>>>>>>>> can get ath9k driver to work on this board using legacy
> >>>>>>>>>> interrupts is to wait for a hardware fix. Right ?
> >>>>>>>>>>
> >>>>>>>>> Correct
> >>>>>>>> I'm confused.  What's the issue with IRQ0 on the P2020RDB?  Is
> >>>>>>>> it used for another purpose?
> >>>>>>> There's a problem with IRQ0 with respect to mini-PCI-E slot. I
> >>>>>>> have Atheros wireless card plugged into it. ath9k wireless
> >>>>>>> driver for this card uses legacy PCI-E interrupts, and I get "irq
> 16:
> >>>>>>> nobody
> >>>> cared"
> >>>>>>> message when driver executes request_irq(). Vivek has come to a
> >>>>>>> conclusion that the problem is related to incorrect IRQ0 routing
> >>>>>>> for mini-PCI-E slot on P2020RDB.
> >>>>>>>
> >>>>>> I would like to understand this issue better, as I seem to be
> >>>>>> running into something similar, and it puts my board design on
> hold.
> >>>>>>
> >>>>>> Can someone (from Freescale) explain what happens if a PCI
> >>>>>> Express end point on the mini-PCIe slot raises a legacy
> >>>>>> interrupt, and where this goes wrong?
> >>>>>>
> >>>>>>   From what document or source code file can I conclude that the
> >>>>>> PCIe legacy interrupt is shared with IRQ0?
> >>>>>>
> >>>>>>
> >>>>>> I found this:
> >>>>>>
> >>>>>> P1020E/P2020E RDB System Errata, Last Update: 2/15/2010:
> >>>>>> Problem:IRQ0 held low
> >>>>>> Fix: Add 4.7K pull-up (to 3.3.V) for RTC_INT_N.
> >>>>>> See R420 in Rev D schematic.
> >>>>>> Add 4.7K pull-up (to 3.3.V) for MCU_INT_N.
> >>>>>> See R423 in Rev D schematic.
> >>>>>>
> >>>>>>
> >>>>> Hello Leon,
> >>>>>
> >>>>>    Yes you are right, PCIe leagacy interrupt is shared with IRQ0.
> >>>>> For
> >>>> Atheros issue.
> >>>>>    Can you please try followings, Meanwhile I will try to dig into
> it.
> >>>>>
> >>>>> http://old.nabble.com/Problem-with-mini-PCI-E-slot-on-P2020RDB-td2
> >>>>> 68
> >>>>> 02
> >>>>> 038.html
> >>>>>
> >>>>> Regarding sata_sil24, Please see my e-mail on Linux-ide for
> >>>>> correct
> >>>> IDSEL value.
> >>>>> Please first try IDSEL value mentioned in email on Linux-ide. Then
> >>>>> try
> >>>> this URL..
> >>>>> --Prabhakar
> >>>>>
> >>>>> _______________________________________________
> >>>>> Linuxppc-dev mailing list
> >>>>> Linuxppc-dev@lists.ozlabs.org
> >>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >>>>>
> >
