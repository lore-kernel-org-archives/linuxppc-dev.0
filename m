MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15214.33465.500189.767261@mediaone.net>
Date: Mon, 6 Aug 2001 07:42:49 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: Olaf Hering <olh@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
In-Reply-To: <20010806100644.A6859@suse.de>
References: <20010805200639.A14938@suse.de>
	<Pine.LNX.4.05.10108060933320.4858-100000@callisto.of.borg>
	<20010806100644.A6859@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:
 > The correct fix is either "video=1280x1024-8@60" as kernel arg (that may
 > work)

OK, I just had time to rebuild 2.4.8-pre3-ben0 with the patch undone.
This video arg with that kernel doesn't solve the problem.  I still
get no video on boot.



 > or the aty128fb driver must check the panel size.

Sounds like this proper patch is going to be necessary.  In the
meantime I'll use the workaround of clobbering the values in one of
the existing modes.

--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
