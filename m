Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 7EC16DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 02:05:35 +1100 (EST)
Date: Tue, 9 Jan 2007 09:05:19 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20070109150519.GD8122@localdomain>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17827.5922.667200.166153@cargo.ozlabs.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Manish Ahuja writes:
> 
> > During power outages, the ups notifies the system for a shutdown. In the 
> > current setup, it isn't possible to power on when power is restored. 
> > This patch fixes the issue by calling the right ibm,power-off-ups token 
> > during such events. It also adds a proc interface so that rc.powerfail 
> > can parse the epow events and modify the power-off behavior accordingly 
> > to enable the right token to be called.
> 
> Creating new non-process-related files in /proc is frowned upon these
> days, so we'll have to find somewhere in /sys for this.  Anybody got a
> suggestion?

Maybe a sysctl instead?
