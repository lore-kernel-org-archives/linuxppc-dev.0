To: schmitz@opal.biophys.uni-duesseldorf.de
Cc: ajoshi@shell.unixbox.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New XFree86-pmac rsync tree
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
In-Reply-To: <3977018F.35968D3A@biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.10.10007171100220.22569-100000@opal.biophys.uni-duesseldorf.de>
	<20000720221208U.kohkichi@venus.dti.ne.jp>
	<3977018F.35968D3A@biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000722122107S.kohkichi@venus.dti.ne.jp>
Date: Sat, 22 Jul 2000 12:21:07 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Thu, 20 Jul 2000 15:41:35 +0200, Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> said:

Schmitz> You will need fbbpp = 16 for 15 bit. And Ani's
Schmitz> latest (yesterday's) source has no color or accel
Schmitz> problems whatsoever for me.

Great!!
I did rsync today, and all my problems vanished without
changing my XF86Config.

The result of x11perf -scroll500 is;

Sync time adjustment is 0.1772 msecs.

    400 reps @  15.3786 msec (    65.0/sec): Scroll 500x500 pixels
    400 reps @  15.2951 msec (    65.4/sec): Scroll 500x500 pixels
    400 reps @  15.2642 msec (    65.5/sec): Scroll 500x500 pixels
    400 reps @  15.2559 msec (    65.5/sec): Scroll 500x500 pixels
    400 reps @  15.2519 msec (    65.6/sec): Scroll 500x500 pixels
   2000 trep @  15.2891 msec (    65.4/sec): Scroll 500x500 pixels

So, X on my iMac runs about three times faster than it used
to with fbdev.

Thank you very much.

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
