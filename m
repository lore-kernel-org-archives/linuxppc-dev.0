Date: Tue, 17 Oct 2000 21:06:28 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Thomas Graichen <graichen@innominate.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
In-Reply-To: <news2mail-pongs8.j51.ln@liquid.bln.innominate.de>
Message-ID: <Pine.LNX.4.10.10010172057330.27337-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> is anyone trying to get the now opensource staroffice to compile on
> linux/ppc?

I've given up on this - the build tools included in the source package are
binary only (Intel or Sparc), no sources so far as I can see, and the
stuff in config_office has a number of hardcoded assumptions that make
life miserable (gcc version == 2.95.2, jdk 1.2.2 which requires glibc
2.1.3, Linux only exists on Intel and Sparc, ...). Basically, it sucks.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
