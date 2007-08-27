Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id CB7A0DDE99
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 06:15:05 +1000 (EST)
Date: Mon, 27 Aug 2007 12:03:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [linux-pm] [PATCH, RFC] linkstation: implement standby
Message-ID: <20070827100316.GD1972@elf.ucw.cz>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun 2007-08-26 02:03:49, Guennadi Liakhovetski wrote:
> Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
> use it for linkstation standby.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks okay to me. I'm glad to see "standby" is present on non-i386
machines, too.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
