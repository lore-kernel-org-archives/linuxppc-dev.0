From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Graichen <thomas.graichen@innominate.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc initrd problem?
Date: Sun, 25 Feb 2001 01:48:58 +0100
Message-Id: <19350119182042.5890@smtp.wanadoo.fr>
In-Reply-To: <news2mail-97967l$g4g$2@mate.bln.innominate.de>
References: <news2mail-97967l$g4g$2@mate.bln.innominate.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>is there any known problem with initrd's on the ppc?
>
>i am currently trying to get a small initrd based standalone system
>working on the ppc like i did for the i386
>
>  http://innominate.org/~graichen/projects/miniroot/
>
>to make the playing around with the xfs filesystem a bit more
>comfortable but it does not really boot on the ppc (new world
>mac, 2.4.1 kernel, SuSE 7.0/ppc) ...

It's a 32Mb initrd ? Well, it's possible that it gets broken then. I'm
not sure yaboot support such a large ramdisk. I'll give it a look.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
