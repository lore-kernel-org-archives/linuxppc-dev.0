Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Subject: Re: Rage128 support for resolutions less than panel resolution?
Date: Tue, 4 Dec 2001 19:25:03 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.40.0112041017530.8200-100000@andromeda.dsdk12.net> <20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there> <1007509665.21511.38.camel@pismo>
In-Reply-To: <1007509665.21511.38.camel@pismo>
MIME-Version: 1.0
Message-Id: <20011205002204.RXBE9080.tomts7-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> One thing I noticed is that when I use the timings from 1024x768-60 for
> 640x480, the vertical refresh is shown as 130 Hz. That doesn't harm the
> panel?

I don't know.  :-(

My limited understanding is that there is only one fixed timing for the
lcd and dfp displays and the stretch registers fill up the full horizontal
and vertical resolution (the same number of horizonntal and vertical bits
is always turned on) no matter what.  So the timing should be exactly the
same shouldn't it?

If you are worried you can try changing the refresh rate to see what
impact that has.

Sorry I can't be more help.

Take care,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
