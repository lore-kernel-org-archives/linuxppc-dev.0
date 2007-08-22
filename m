Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E4116DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 01:15:52 +1000 (EST)
Date: Wed, 22 Aug 2007 08:15:39 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: ravi.rao@rflelect.com
Subject: Re: Kerenel crashes every other Boot..
References: <OF486D59BE.E9F90F84-ON8525733F.005162F2-8525733F.0051B481@rflelect.com>
In-Reply-To: <OF486D59BE.E9F90F84-ON8525733F.005162F2-8525733F.0051B481@rflelect.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20070822151523.AF7A910A0071@mail78-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ravi,

you need to provide more information, for example, where does the kernel
crash, any serial console output that you see when it crashes, etc.

Cheers,
   Wolfgang


ravi.rao@rflelect.com wrote:
> 
> Hi All,
>     I have a PPC 405EP custom target. I based most of my software on the
> EP405 Taihu reference and now I am able to load the 2.6.21 kernel and
> with a minimum initramfs I also get the busy box prompt. I see a strange
> poblem it fails(linux crashes) every other boot. Can any one please tell
> me what may be happening ???
> Thanks,
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com>
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
> 
>  
> 
> 
> _CONFIDENTIALITY NOTE_
> 
> This e-mail, including any attachments, may contain confidential and/or
> legally privileged information.  The Information is intended only for
> the use of the individual or entity named on this e-mail .  If you are
> not the intended recipient, you are hereby notified that any disclosure,
> copying, distribution, or the taking of any action in reliance on the
> contents of this transmitted Information is strictly prohibited. 
> Further, if you are not the intended recipient, please notify us by
> return e-mail and delete the Information promptly.
> 
>  
> 
>  
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
