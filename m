Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 2E7F867F90
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 06:09:25 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so472963nzp
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 13:09:24 -0700 (PDT)
Date: Fri, 19 Aug 2005 14:06:00 -0600
To: ??? <rober@opnet.com.tw>, linuxppc-embedded@ozlabs.org
Message-ID: <20050819200600.GB28916@siegfried.thelikelysolution.ca>
References: <43C18850A2E42CD14825706200226758.0022678048257062@opnet.com.tw>
	<001401c5a494$ffd659c0$1a0e000a@RoberHsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001401c5a494$ffd659c0$1a0e000a@RoberHsu>
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

On Fri, Aug 19, 2005 at 04:07:04PM +0800, ??? wrote:
> Hi Grant:
> 
>    I'm already try it.But it still fail.Why i used so large ramdisk, is
> because net-snmp 5.x.x
> are too big, snmpd + snmptrapd almost 10M byte.
I think you're missunderstanding me.

"/sbin/mke2fs -F m0 ramdisk" means:
    create ext2 filesystem on file 'm0' of size 'ramdisk'
"/sbin/mke2fs -F -m0 ramdisk" means:
    create ext2 filesystem on file 'ramdisk' with 0% reserved

It looks like your missing a dash (-) for the 'm' option

g.
