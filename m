Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (bebe.enoyolf.org [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF953DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 16:03:58 +1100 (EST)
In-reply-to: <20080201030542.GX14201@localdomain> 
References: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
	<20080201030542.GX14201@localdomain>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 0/5] ehea checkpatch fixups 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2008 22:35:18 -0600
Message-ID: <472.1201840518@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@garzik.org>,
	Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 31 Jan 2008 21:05:42 CST, Nathan Lynch wrote:
> Doug Maxey wrote:
> > 
> > A small set of fixups for checkpatch.
> > 
> > Based on upstream pull from a few hours ago.
> 
> Er, ehea doesn't even build right now[1], maybe that could get fixed
> first?  :-)
> 
> [1] http://lkml.org/lkml/2008/1/28/337

For sure these won't break it any worse.  ;)  Think of these more as a 
janitorial thing vs. structural.

Doesn't gregkh's patch work?  At least for the interim?

Jan-Bernd,
What tools are looking in sysfs? distro scripts?  I don't see any link 
between ethtool and the driver (other than the driver internal bits).
Am I missing something obvious?

++doug
