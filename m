Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH 0/2] NMI IPI work in progress for Linux and OPAL
Date: Wed, 13 Sep 2017 02:05:51 +1000
Message-Id: <20170912160553.13422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have Linux and OPAL patches that make the NMI IPI facility work on
a POWER9 DD1 here, lightly tested. It works for threads that are running
and are in stop (at least the stop0_lite state enabled in DD1).

Comments on the OPAL patch in particular would be good. Next step will
be more testing with DD2 and different idle states.

This was taken mostly from pdbg but I have ended up changing a few
things (e.g., to make it work in idle state).

Thanks,
Nick
