Message-ID: <3933EAF2.B966B675@embeddededge.com>
Date: Tue, 30 May 2000 12:23:14 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Matthew Locke <mlocke@jps.net>
CC: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpx_cfg() copy to NVRAM?
References: <NDBBJCEBJMJJJBIMCFBEOEDJCDAA.mlocke@jps.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew Locke wrote:

> SYPCR needs to be set to turn the watchdog off. Can't remember the value and
> I don't have the docs in front of me.

0xffffff88



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
