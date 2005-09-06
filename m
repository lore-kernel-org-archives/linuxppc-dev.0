Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C0A7680F2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 23:48:49 +1000 (EST)
Date: Tue, 6 Sep 2005 14:48:45 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-Id: <20050906144845.1e603c72.ajz@cambridgebroadband.com>
In-Reply-To: <431D8F5B.9050803@ru.mvista.com>
References: <20050906133122.225a0922.ajz@cambridgebroadband.com>
	<431D8F5B.9050803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI on MPC827x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 06 Sep 2005 16:45:15 +0400
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> Alex Zeffertt wrote:
> > Hi list,
> > 
> > Does the linuxppc kernel support PCI on PowerQUICC II chips?  If so, in which patch/release was
> > it added?
> > 
> The PCI bridge for 8272ADS has been added in 2.6.12-rc6. This stuff 
> should work on PQ2FADS as well.
 
Thanks Vitaly.  Unfortunately we're using linux-2.4.25.

Has anybody backported the PCI bridge to 2.4?  If not, do you think it's a lot of work?

Alex
