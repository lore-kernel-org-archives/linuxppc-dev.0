Return-Path: <krom@dgt.com.pl>
Received: from dgt-lab.com.pl (unknown [195.117.141.6])
	by ozlabs.org (Postfix) with ESMTP id E0AB467A2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 00:45:34 +1100 (EST)
Message-ID: <41EE5C98.4000607@dgt.com.pl>
Date: Wed, 19 Jan 2005 14:11:52 +0100
From: Wojciech Kromer <krom@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: 8250 FCC in half-duplex mode transmit timed out
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello again,
after few month of silence, i found this group here :)
thx for getting it back to live

i have new problem with 8250 FCC in ethernet mode,
it works fine in FDX, but after some time of heavy transmit all BD-s 
become busy

the only way to continue is to reset FCC, but ituation repeats after 
10-30 seconds

any sollution?

i've tried out CPM11,CPM112 and CPM119 microcode pathes from freescale,
no success with this stuff

by the way: does anyone know how to apply muiltiple patches at same time?
