Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 8F251680A5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 16:18:31 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id i1so401132nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 23:18:29 -0700 (PDT)
Date: Fri, 19 Aug 2005 00:15:08 -0600
To: ????????? <rober@opnet.com.tw>, linuxppc-embedded@ozlabs.org
Message-ID: <20050819061508.GA28537@siegfried.thelikelysolution.ca>
References: <1124416918.6752.1.camel@banana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124416918.6752.1.camel@banana>
From: Grant Likely <glikely@gmail.com>
Subject: Re: How to build more than 16M ramdisk for u-boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2005 at 10:01:58AM +0800, ????????? wrote:
> Hi all:
> 
>     I found if i build ramdisk more than 16M, i'll got error at using
> mke2fs command.
> 
> dd if=/dev/zero of=ramdisk bs=1024k count=20
> 
> /sbin/mke2fs -F m0 ramdisk
> mke2fs 1.36 (05-Feb-2005)
> mke2fs: bad blocks count - ramdisk
typo?

try: /sbin/mke2fs -F -m0 ramdisk
