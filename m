Return-Path: <bgat@billgatliff.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id CC613B7D0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 06:12:44 +1000 (EST)
Received: by pzk33 with SMTP id 33so1460418pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 13:12:42 -0700 (PDT)
Message-ID: <4BC77391.9000806@billgatliff.com>
Date: Thu, 15 Apr 2010 15:14:09 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
	<4BC70E47.9010408@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
In-Reply-To: <201004151553.53426.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roman Fietze wrote:
> Then I added void shadowUpdatePackedSwapped16() and
> shadowUpdatePackedSwapped32() which I was using instead of the
> original *Weak functions, which in turn uses the above swap routine
> when copying from shadow to the device.
>   

I'm not sure what the *Weak stuff is doing.  Can I just hack
shadowUpdatePacked() itself?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
