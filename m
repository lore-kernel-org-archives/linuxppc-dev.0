Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:32 +1000
Subject: [RFC/PATCH 0/7] Powerpc MSI stuff
Message-Id: <1159480412.269240.988552559176.qpush@concordia>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's what we've got so far towards an MSI layer for Powerpc. Perhaps
it's interesting for other people too.

Neither of the backends have had any real testing, waiting on hardware, but
I think there's enough to make me think the design makes (some) sense.

cheers
