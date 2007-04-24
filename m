Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 2CAF8DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 15:45:29 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
Date: Tue, 24 Apr 2007 07:46:04 +0200
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<20070424000153.GD23995@crusty.rchland.ibm.com>
	<ada647m635h.fsf@cisco.com>
In-Reply-To: <ada647m635h.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704240746.05129.sr@denx.de>
Cc: Paul Mackerras <paulus@samba.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 24 April 2007 02:12, Roland Dreier wrote:
> > > I recall dimly that there was some user-visible difference between the
> > > 440GP and the other 440 processors, and that's why we made the
> > > platform string different.  I don't recall what the difference was.
>
> FWIW, I've run the same userspace (binaries) on 405GPr, 440GP and
> 440SPe without any problems.  Not that I'm a 4xx expert by any
> stretch, but I don't know of anything special about the 440GP.

I don't know of any differences either. So I'm voting to change the platform 
to ppc440 too.

Best regards,
Stefan
