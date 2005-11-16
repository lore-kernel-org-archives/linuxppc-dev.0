Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4F14B68724
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 05:25:49 +1100 (EST)
Date: Wed, 16 Nov 2005 19:25:37 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051116182537.GC3080@localhost>
References: <1130999620.4680.28.camel@gaston> <20051116180925.GB3080@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20051116180925.GB3080@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2005 at 07:09:26PM +0100, Wolfgang Pfeiffer wrote:

> Ben, I just compiled and installed a 2.6.14.1 from kernel.org with
> none of your patches from this thread applied to it, and I have no
> sleep/wakeup probs with it so far: about 3 instances of sleep/wakeup
> until now, all of them successful.
> 
> Maybe I even made it a bit more complicated for the system, as I
> connected a USB HUB, with 4 ports, to the machine: It just seems to
> work ... [ ... ]

Just for the sake of completeness: I have (SCSI) problems with 2.6.14.1,
but none of them seem to be USB/sleep related:
<http://sourceforge.net/mailarchive/forum.php?thread_id=8964383&forum_id=5389>

Not being sure whether this latter URL works: I just read "The
SourceForge.net Website is currently down for maintenance" But the
name of the thread up there is:
"Fw: 2.6.14.1: Loading FireWire disk fails. Fix: "modprobe ieee1394
disable_irm=1""

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
Key fingerprint = A8CA 9D8C 54C4 4CC1 0B26  AA3C 9108 FB42 E303 7113
