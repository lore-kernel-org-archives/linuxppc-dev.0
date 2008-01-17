Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9D615DDEE6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:50:45 +1100 (EST)
Date: Thu, 17 Jan 2008 17:59:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
Message-ID: <20080117145903.GA4535@localhost.localdomain>
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul, Kumar,

On Thu, Jan 17, 2008 at 03:39:07PM +1100, Paul Mackerras wrote:
> Includes commits pulled from Josh Boyer's tree.

Um.. Probably I'm being importunate.. if so, just command me to sit
silent and wait. ;-) But how about these down here? Ones that touches
drivers/net/ are having "Acked-by: Jeff Garzik <jeff@garzik.org>"
thus meant to go through one of powerpc tree. Not sure through which
one exactly.

http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047777.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047778.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047779.html

^^ are mandatory to make MPC8349E-mITX's ENET1-ENET5 actually work.
Plus, as you may notice all of them having "777" in the message id,
they ought to be lucky, despite that today they're applying with
fuzz. :-)

http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048473.html

^^ fixed phy support for fs_enet. Needed for some other boards, I
presume.


Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
