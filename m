Date: Wed, 2 Oct 2002 11:03:21 +1000
From: Erik Christiansen <erik@dd.nec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Is it binutils-2.13.90.0.4 or is it me?
Message-ID: <20021002010320.GA601@dd.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   Following the mini-howto on penguinppc.org, I started with compilation
of binutils.

   ./configure --target=powerpc-linux finished in a happy frame of mind,
but make spat the dummy, flagging errors on some rather elusive
scripting:

cd .. \
  && CONFIG_FILES=po/Makefile.in:po/Make-in \
     CONFIG_HEADERS= /bin/sh ./config.status
creating po/Makefile.in
make[3]: Leaving directory `/usr/local/src/binutils-2.13.90.0.4/bfd/po'
make[3]: Entering directory `/usr/local/src/binutils-2.13.90.0.4/bfd/po'
file=./`echo sv | sed 's,.*/,,'`.gmo \
  && rm -f $file && PATH=../src:$PATH no -o $file sv.po
/bin/sh: no: command not found
make[3]: *** [sv.gmo] Error 127
make[3]: Leaving directory `/usr/local/src/binutils-2.13.90.0.4/bfd/po'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/usr/local/src/binutils-2.13.90.0.4/bfd'
make[1]: *** [all-recursive-am] Error 2
make[1]: Leaving directory `/usr/local/src/binutils-2.13.90.0.4/bfd'
make: *** [all-bfd] Error 2

   Now, grep -r 'no -o' /usr/local/src/binutils-2.13.90.0.4/bfd/po draws
a blank, so before looking further for where it could be fixed, I
thought I'd ask whether going back a version or two might provide
smoother sailing?

Regards,
Erik

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
