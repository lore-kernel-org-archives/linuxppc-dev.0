Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id CAE78679E9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 05:34:09 +1000 (EST)
Subject: Re: DTC/dts modifications
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1146512012.24239.28.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 01 May 2006 14:33:32 -0500
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-04-29 at 11:00, Kumar Gala wrote:
> All,
> 
> What evilness would it be to change the use of '#' in the .dts format  
> to some other character like '$' or '%'.

Uh, use of '#' for what?  Current comment style is
either C or C++, ie, /* ... */ or //.

>   The problem is the use of  
> '#' prevents use from using cpp which would make some aspects of  
> building up .dts for boards far more useful.

I think to get CPP to be usable, it will need to handle
the # emitted line-location markers, "# <line> <file> <level>".

> We can easily provide a one line script to convert people's .dts to  
> the new format.

I don't think there is a conversion necessary yet.
Did I miss something here?

Thanks,
jdl
