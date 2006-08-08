Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id A6EFB67B53
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 02:30:11 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060808151940.GB29823@pb15.lixom.net> 
References: <20060808151940.GB29823@pb15.lixom.net>
	<OFBE03114B.A48C7930-ON482571C4.001E80F2-482571C4.0020774E@cn.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Umount reiserfs partition caused crash on 2.6.18-rc3-mm2 
Date: Tue, 08 Aug 2006 17:29:59 +0100
Message-ID: <23904.1155054599@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: Lei CL Cheng <chenglcl@cn.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson <olof@lixom.net> wrote:

> This doesn't at first look seem like a PPC-specific bug. You will probably
> get more eyes on the problem if you report it on LKML instead.

That may be due to one of my patches, and if so it's not PPC specific.

Do you get a bug report looking something like this:

> BUG: Dentry ffff810037c573e8{i=3,n=.reiserfs_priv} still in use (1) [unmount of reiserfs hdc7]
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at fs/dcache.c:611

David
