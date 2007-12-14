Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 791E8DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 12:58:07 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so274882anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Dec 2007 17:58:06 -0800 (PST)
Date: Thu, 13 Dec 2007 19:57:59 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Bruce_Leonard@selinc.com
Subject: Re: How is a device tree used to specifiy flash?
Message-ID: <20071213195759.0de2a917@vader.jdub.homelinux.org>
In-Reply-To: <OFE841AC61.3D44C925-ON882573B0.007FA29F-882573B0.0080F67D@selinc.com>
References: <OFE841AC61.3D44C925-ON882573B0.007FA29F-882573B0.0080F67D@selinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 13 Dec 2007 15:28:37 -0800
Bruce_Leonard@selinc.com wrote:

> Okay I just don't get it, but that's not a surprise.  I'm booting a 2.6.23 
> kernel on an MPC8347 using u-boot 1.3.0.  I'm trying to use the device 
> tree to spec my single Spansion/AMD NOR flash part and I can't get the 
> kernel to recognize the part.  Or maybe I just don't know how to tell if 
> the kernel is recognizing the part.  It's possible that everything is fine 
> and I'm just to dumb to know it.
> 
> So I've got a Spansion S29GL128N flash part and the following entry in my 
> device tree:
> 
> flash@ff000000 {

What bus is this node under in your DTS file?  Make sure that bus is
getting probed in the platform code.

josh
