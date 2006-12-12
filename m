Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200612121450.41561.jk@ozlabs.org>
References: <200612120323.kBC3NjEW004119@toshiba.co.jp>
	<200612121450.41561.jk@ozlabs.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 15:42:39 +1100
Message-Id: <1165898559.11914.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also, do you need beat_errno? you return the same value in every 
> function anyway.

It's actually a very bad thing to have a global errno... It's racy, how
do you do if multiple CPUs modify it at the same time ? Thus the content
of it is worthless, so just drop it ;-)

Ben.
 
