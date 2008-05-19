Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 65069DDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 May 2008 14:18:19 +1000 (EST)
MIME-Version: 1.0
Date: Mon, 19 May 2008 13:18:35 +0900
Subject: Re: Xilinx PowerPC
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: dhlii@dlasys.net
Message-ID: <JN200805191318356.11133187@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <4830F388.3060709@dlasys.net>
References: <480BA36D.1080000@dlasys.net>
	<fa686aa40804201314m27caf4fau72956df9dd5d350d@mail.gmail.com>
	<480BA821.2030109@dlasys.net>
	<fa686aa40804201548o503e9b19p4081cec653a1acd2@mail.gmail.com>
	<480BD66B.90001@dlasys.net> <JM200804230904046.2598203@co-nss.co.jp>
	<482EFB8F.9090402@dlasys.net> <JV200805181113103.2504562@co-nss.co.jp>
	<4830F388.3060709@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David-san,

I posted this source code so that usage of SDMA could be shared.
Probably this code will be able to be used also by Virtex-5 FXT.
Since this source code is a reference level and start point as you
say, it is happy that it is maintainable with people of this ML.
I'll leave it in your hands about author.

Best Regards,
Yoshio Kashiwagi - Nissin Systems

> I am preparing my own version of Yoshio's driver. Since most of my
> changes are re-ordering, renaming, or other items of small 
consequence,
> I will leave Yoshio as the author - unless he prefers otherwise.
> 
> I hope to have it ready to submit as a patch in a few days.
> If Yoshio is unhappy with any of the changes I have made or chooses to
> submit his original code or some permutation I will withdrawl mine.
> 
> While adding OF checksum offloading, ... would be nice,
> All I am looking to do is get something that can start its way into 
the
> kernel.
> This driver is working for me - with very light testing so far.
> 
> If no one else is willing to Shepard something in, then I will try.
> Hints, clues, etc would be very much appreciated.
> I presume that if this driver is acceptable here, the next step would 
be
> forwarding it to linux-netdev ?
> 
> Yoshio Kashiwagi wrote:
> > David-san,
> >
> > This driver must add some corrections, for example, Checksum-
offloading
> > is incomplete as you say it. As for me, it is very happy to obtain
> > your cooperation. Let me know if I can be of any work for it.
> >
> > Moreover, although I wrote the xps_ll_temac driver for u-boot of a 
very 
> > simple single SDMA descriptor, I have not got used and put in the
> > contribution way.
> >
> > Best Regards,
> > Yoshio Kashiwagi - Nissin Systems
> 
> -- 
> Dave Lynch                            DLA Systems
> Software Development:                          Embedded Linux
> 717.627.3770         dhlii@dlasys.net       http://www.dlasys.net
> fax: 1.253.369.9244                      Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies 
too numerous to list.
> 
> "Any intelligent fool can make things bigger and more complex... It 
takes a touch of genius - and a lot of courage to move in the opposite 
direction."
> Albert Einstein
