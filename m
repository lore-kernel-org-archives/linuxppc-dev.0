Return-Path: <randy.dunlap@oracle.com>
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C831BDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 15:23:15 +1100 (EST)
Date: Wed, 19 Mar 2008 21:21:21 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, v4l-dvb-maintainer@linuxtv.org
Subject: Re: linux-next: Tree for March 20
Message-Id: <20080319212121.9705ca9a.randy.dunlap@oracle.com>
In-Reply-To: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Theodore Tso <tytso@MIT.EDU>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Mar 2008 14:39:53 +1100 Stephen Rothwell wrote:

> Hi all,
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> (tar balls at
> http://www.kernel.org/pub/linux/kernel/people/sfr/linux-next/).

gcc doesn't like nested /* comments:

next-20080320/drivers/media/video/bt8xx/bttv-cards.c:3030:38: warning: "/*" within comment
next-20080320/drivers/media/video/bt8xx/bttv-cards.c:3032:20: warning: "/*" within comment

---
~Randy
