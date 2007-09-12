Return-Path: <Martin.Leisner@xerox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: frequency scaling for 7448
Date: Wed, 12 Sep 2007 16:23:12 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5BEA@USA0300MS03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've written a frequency scaling module for a 7448 which plugs into the
linux governors.

I plugged in into 2.6.20.16 on a taiga board.

I have a good handle on how arch/i386/kernel/cpu/cpufreq handles
cpufreq, its not clear how
it should be done in the powerpc -- there's some frequency scaling stuff
in powermac/, but its not
useful for taiga board  (I like the ToDO -- needs a big cleanup).

What I'm seeing on the taiga board:
	1) when I enter nap, the ethernet seems to be VERY lethagic,
unless I spin the processor...
      2) /2 works fine, /4 causes the ethernet/disk to break...

I'm very open to suggestions...it also appears cpufreq can be a module
on SOME architectures...

marty
