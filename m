Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE005.bigfish.com (wa4ehsobe005.messaging.microsoft.com
	[216.32.181.15]) by ozlabs.org (Postfix) with ESMTP id A98C0DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 05:04:30 +1100 (EST)
Message-ID: <49B55A21.2010801@am.sony.com>
Date: Mon, 9 Mar 2009 11:04:17 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] [PATCH 7/7] powerpc/ps3: Add rtc-ps3
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<20090309151216.17f13862@i1501.lan.towertech.it>
In-Reply-To: <20090309151216.17f13862@i1501.lan.towertech.it>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-m68k@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@mcmartin.ca>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Geert.Uytterhoeven@sonycom.com,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On 03/09/2009 07:12 AM, Alessandro Zummo wrote:
> On Mon,  9 Mar 2009 14:26:23 +0100
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>> +
>> +MODULE_AUTHOR("Sony Corporation");
> 
>  real name, if possible and a contact address
>  here . Just in case I need someone to bother :)

Please look at the MAINTAINERS file, that will give
the contact for PS3.  It is much easier to maintain
a single place for the contact than many spread
throughout the kernel sources.

-Geoff
