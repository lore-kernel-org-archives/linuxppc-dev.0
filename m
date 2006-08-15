Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17633.18057.778991.483461@cargo.ozlabs.ibm.com>
Date: Tue, 15 Aug 2006 13:59:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: <matt@genesi-usa.com>
Subject: RE: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
References: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
Cc: 'Albert Cahalan' <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey writes:

> Book I compatible PowerPC's have had a "no-executable" bit in
> the page protection flags since the dark ages.. see page 7-38
> and 7-39 of the 'Programming Environments Manual for 32-Bit
> Microprocessors'.. this document predates even the G3.

What are you referring to?  I have a copy of the PEM from pre-G3 days,
and a copy that I downloaded just now, and neither of them have an N
bit in the PTE (and yes I just looked carefully through pages 7-38 and
7-39).

There is an N bit in the segment register format, and that's what
Albert is using.

> As far as the documentation goes, you can make the page
> readable and writable to the LSU, but the N bit causes the
> instruction fetch to cause a machine check. That's pretty
> "not-executable" to me at least :)

A machine check is nasty, because it may not be recoverable...

Paul.
