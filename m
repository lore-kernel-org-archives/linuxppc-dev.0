Date: Tue, 30 Oct 2001 12:21:11 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
Message-ID: <20011030122110.F13806@altus.drgw.net>
References: <20011030121221.E13806@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011030121221.E13806@altus.drgw.net>; from hozer@drgw.net on Tue, Oct 30, 2001 at 12:12:21PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 30, 2001 at 12:12:21PM -0600, Troy Benjegerdes wrote:
>
> Okay, I pulled 2_4_devel this morning and built and SMP kernel my MTX.. it
> booted up, but some weird things started happening..

I am 'reliably' able to reproduce the following:

kalmia:/var/log# /etc/init.d/squid restart
Restarting proxy server:
/etc/init.d/squid: line 3:   450 Segmentation fault      start-stop-daemon
--quiet --start --pidfile $PIDFILE --exec $DAEMON -- $SQUID_ARGS
</dev/null
squid.



--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
