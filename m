Date: Mon, 22 Nov 1999 14:40:54 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991122144054.C12973@hq.fsmlabs.com>
References: <19991122120429.031138> <19991122124702.006073@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991122124702.006073@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Mon, Nov 22, 1999 at 12:47:02PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'll check this patch with the latest 2.2 to see how it goes.  Would using
the bootinfo structure we talked about a few weeks ago help?  I'd like to
unify things a bit with it but I'm not sure how many problems it would
solve and how many it could cause.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
