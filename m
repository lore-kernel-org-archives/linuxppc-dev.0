MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14804.42077.837821.274373@esb.bbn.com>
Date: Fri, 29 Sep 2000 10:17:01 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <39D484DD.30E5B75D@student.ethz.ch>
References: <Pine.LNX.4.10.10009281310500.3468-100000@cassiopeia.home>
	<39D484DD.30E5B75D@student.ethz.ch>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > Mr Shapiro, please test if this makes the ati driver work in your
 > triple-head box.

No luck.

Booting with BootX, the ati driver still hoses linux when X starts.  I
can send you (or post) the log.  Worse, using the new fbdev driver
itself produces a confused display on the 2nd and 3rd monitor, with
images appearing multiple times.

Booting with miBoot, any attempt to run X with either driver still
hoses linux.

I don't have quik booting working yet, so I couldn't test that.

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
