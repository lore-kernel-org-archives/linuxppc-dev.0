Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A6016DDFAD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 20:19:34 +1100 (EST)
Subject: Re: [PATCH] ps3: vuart: semaphore to mutex
From: Daniel Walker <dwalker@mvista.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0801110919500.10759@vixen.sonytel.be>
References: <20080111042137.378247237@mvista.com>
	<Pine.LNX.4.64.0801110919500.10759@vixen.sonytel.be>
Content-Type: text/plain
Date: Fri, 11 Jan 2008 01:17:46 -0800
Message-Id: <1200043066.29897.64.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-11 at 09:20 +0100, Geert Uytterhoeven wrote:
> On Thu, 10 Jan 2008, Daniel Walker wrote:
> > This probe_mutex conforms to the new struct mutex type.
> > This patch converts it from the old semaphore to the new struct mutex.
> 
> The PS3 tree already has this change.
> 
> With kind regards,

Ok, thanks..

Daniel
