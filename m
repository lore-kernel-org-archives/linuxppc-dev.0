Message-ID: <3C0509E7.938BB01D@fh-dortmund.de>
Date: Wed, 28 Nov 2001 16:59:35 +0100
From: Ralf Weidemann <weidemann@fh-dortmund.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.16-ben0: clock broken ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I get a clock shift of about a month in the latest 2.4.16-ben0.
Something broken ?

Ralf


[ralfw@tibook ralfw]$ uname -a
Linux tibook.sw2.fb4.fh 2.4.15-ben0 #1 Sun Nov 25 12:12:56 CET 2001 ppc unknown
[ralfw@tibook ralfw]$ date
Wed Nov 28 16:34:46 CET 2001
[ralfw@tibook ralfw]$ hwclock --show
Wed 28 Nov 2001 04:34:50 PM CET  -0.790044 seconds
[ralfw@tibook ralfw]$ hwclock -v
hwclock 2.4c/util-linux-2.11f


[ralfw@tibook ralfw]$ uname -a
Linux tibook.sw2.fb4.fh 2.4.16-ben0 #3 Wed Nov 28 16:20:49 CET 2001 ppc unknown
[ralfw@tibook ralfw]$ date
Fri Dec 28 16:39:25 CET 2001
[ralfw@tibook ralfw]$ hwclock --show
Fri 28 Dec 2001 04:39:36 PM CET  -0.827878 seconds
[ralfw@tibook ralfw]$ hwclock -v
hwclock 2.4c/util-linux-2.11f

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
