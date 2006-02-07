Return-Path: <David_Antliff@stratexnet.com>
Received: from exchwenz03.wenz.global.vpn (unknown [202.27.34.1])
	by ozlabs.org (Postfix) with ESMTP id CCBC868A7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 09:46:06 +1100 (EST)
Subject: Re: Common Flash Interface v1.4 and MTD support in Linux-2.4.4 kernel
From: David Antliff <David_Antliff@stratexnet.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060207210421.57015352659@atlas.denx.de>
References: <20060207210421.57015352659@atlas.denx.de>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 11:46:05 +1300
Message-Id: <1139352365.6285.6.camel@theoden.middle_earth>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-02-07 at 22:04 +0100, Wolfgang Denk wrote:
> In message <1139309578.32218.7.camel@yoda.jdub.homelinux.org> you wrote:
> >
> > > What would you suggest? Yes, I am happy for a 'quick fix' but if there
> > > isn't one or it's too risky I am willing to invest the time in doing it
> > > right.
> > 
> > 'quick fix' is to pull the changes from cfi_cmdset_0001.c in MTD CVS
> > back into your kernel.  But I'm not sure how quick that will be given
> > that your kernel is very very old.
> 
> It's not quick at all, and the  ancient  2.4.4  MTD  code  has  other
> problems  at  all.  Swithing to a newer kernel version is very likely
> less trouble.

Josh & Wolfgang, I appreciate your replies - thank you. 

FYI, we have decided to investigate writing a simple block device driver
for this device to get our development back on track with an eventual
goal of upgrading the kernel when time and resources permit. 

MTD is not crucial to our project, it just made a previous task easier
and this current one harder! :)

Thanks again,

David Antliff
