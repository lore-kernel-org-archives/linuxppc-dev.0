Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 9AD0D67E55
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 01:12:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 3 Aug 2005 17:13:10 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F854A@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,=20

> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20

> > Schaefer-Hutter, Peter wrote:=20
> >	Shouldn't that read:
> >	  #define BCSR_SIZE   ((uint)32 * 1024)

> <quotation> (This is from 8272 User Guide, but 885 I guess is the same
in this part)
>	[ ... ]
> <quotation\>

Well, i was just wondering why fads.h and my old 2.4-Kernel define it
'(32*1024)', but
this explains it.

Thank you and best regards,

 Peter
