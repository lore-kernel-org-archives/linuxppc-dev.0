Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 10BEDDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Oct 2008 00:02:12 +1000 (EST)
Date: Sat, 4 Oct 2008 05:58:28 -0800 (AKDT)
From: Nicholas Mc Guire <hofrat@hofr.at>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Subject: Re: SA-RTLinux for ppc?
In-Reply-To: <d2b9ccd90810030835m534f7619xe0be08078bad0019@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0810040551290.2427@vlab.hofr.at>
References: <0B45E93C5FF65740AEAE690BF3848B7AD383BB@rennsmail04.eu.thmulti.com>
	<d2b9ccd90810030835m534f7619xe0be08078bad0019@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> actually i m tryin to find a linux like port for powerpc.
> lookin for a kernel which has very less functionalities.
>

Well then XM2 might be of interest for you - this is really very close to
what SaRTL was doing just based on the XtratuM hypervisor and thus
providing seperated address spaces for the real-time domains (that is they
run in user-mode) It boots stand-alone but can run Linux as a guest - the
development is still at an early stage though, if you are interested in
more details let me know - this is a bit off topic for here I guess. A
number of presentations on both XtratuM and XM2 are scheduled for the 10th
Real Time Linux Workshop in Mexico (Oct 29-Nov 1 2008) see:

 http://www.realtimelinuxfoundation.org/events/rtlws-2008/rtlws10/

thx!
hofrat
