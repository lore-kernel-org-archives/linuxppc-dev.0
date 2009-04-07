Return-Path: <kraxel@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 870D0DDF9D
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 17:52:39 +1000 (EST)
Message-ID: <49DB0628.70502@redhat.com>
Date: Tue, 07 Apr 2009 09:52:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
To: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [PATCH] powerpc: wire up preadv and pwritev
References: <20090407131950.9ab4430b.sfr@canb.auug.org.au>
	<bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
In-Reply-To: <bb33bcf20904062351p63645851h9b33d47f57c57e7f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ltp-list <ltp-list@lists.sf.net>,
	maknayak@in.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

   Hi,

> How about contributing the above test to LTP(http://ltp.sourceforge.net/)
> under GPL ? If you agree, i would soon send you a Patch integrating the same
> to LTP.

Fine with me.  You probably want to remove the hard-coded syscall 
numbers and pickup them from unistd.h instead though.

cheers,
   Gerd
