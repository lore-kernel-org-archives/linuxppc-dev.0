Message-ID: <3B954538.786491A3@mvista.com>
Date: Tue, 04 Sep 2001 17:18:48 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org, pbarada@wm.sps.mot.com
Subject: Re: 405 Walnut Status?
References: <20010830161812.A4855@borg.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:
>
> What kind of shape is the 405 Walnut code in ppc.bitkeeper.com:5000
> linuxppc_2_4_devel kernel?

As of last week, it should build and boot.  There have been some
updates to the bootloader I haven't verified, but it should work.

> I can't figure out how to even config and compile it.

Are you actually using the BK tools?  If so, you should 'bk clone',
then go into the directory and 'bk -r get', 'make walnut_config',
'make oldconfig', 'make dep', 'make zImage'.......



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
