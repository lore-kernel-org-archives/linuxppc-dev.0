Return-Path: <tnt@246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/7] MPC52xx Bestcomm submission for 2.6.24
Date: Sun, 16 Sep 2007 12:53:23 +0200
Message-Id: <11899400103383-git-send-email-tnt@246tNt.com>
Cc: Grant Likely <glikely@gmail.com>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul, Hi everyone,

This series of patch is mainly the bestcomm support for
the mpc5200. It was posted a while ago and received some
comments. Theses are all addressed here (afaik).

The first few patch are more a preparation for what
follows. (rheap module support & extended fields in psc
structure).

The rest is the core support followed by each specific
microcode support. (Previous emails explained the stucture
better, I'm not gonna repeat it here)

This particular version has been tested on the EFIKA and
works fine. Previous versions have been tested on a lot
of different platforms by numerous people. (and since the
changes since last version are cosmetic ...).

This series _doesn_t_ include any driver that actually make
use of bestcomm support. Hopefully theses will come. I
think Domen Puncer sent a cleaned up driver for ethernet.


        Sylvain
