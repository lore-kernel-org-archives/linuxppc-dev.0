Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 7ACCF679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 01:52:21 +1000 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id AAA16377
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 00:48:49 +0900 (JST)
MIME-Version: 1.0
Date: Wed, 11 Oct 2006 00:50:57 +0900
Subject: RE: Linuxppc-embedded Digest, Vol 26, Issue 13
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: Jaap de Jong <jaap.dejong@nedap.com>, linuxppc-embedded@ozlabs.org
Message-ID: <JP2006101100505710.12505093@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <6915D0AE8B9047438F320B466AE30FDD798359@nvs0003.nedap.local>
References: <6915D0AE8B9047438F320B466AE30FDD798359@nvs0003.nedap.local>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your advice.
Although I was not verifying "Digest Vol26 Issue13", cache needed to be
turned OFF for operating 2.4 kernels by Avnet v4fx12mm.
However, when the same kernel was operated by ML403, even if it did not
turn OFF cache, it was operating normally.

Although the default reference design is not verified by v4fx12mm
recently, it is operating normally by 2.6.17.3 kernel and MPMC2 now.

However, if there is fault of infalte in 2.6.17 kernels, there is E-Mail
of Dave-San. Since the ramdisk capacity is 2MB that initrd is operating
normally in my kernel.

Best Regards,

Yoshio Kashiwagi - Nissin Systems

> Not sure...
> I have not been playing with 2.6 kernels but this looks a lot like
> the problems I found when trying to get the 2.4 kernel to work.
> Default for the avnet v4fx12 is to use the opb bus as raminterface.
> You should explicitly select the plb bus...
> 
> Jaap de Jong
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 06 Oct 2006 10:33:53 +0900
> From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
> Subject: Re: Problem with initrd
> To: Glenn.G.Hart@us.westinghouse.com, linuxppc-embedded@ozlabs.org
> Message-ID: <JF2006100610335316.6823078@co-nss.co.jp>
> Content-Type: text/plain; charset=ISO-2022-JP
> 
> Glenn-San,
> 
> Are you developing by the custom-made hardware of V4FX12?
> If the 16-bit memory controller is used, it may have a problem in the
> memory controller.
> 
> Can you try the memory controller of http://www.xilinx.com/mpmc2?
> I confirmed that the 16-bit memory controller of MPMC2 worked 
correctly
> by Linux. Or I can send the ramdisk image for 2.6.17.3 kernel which I 
am
> using to you.
> 
> Yoshio kashiwagi - Nissin Systems
> 
__________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
