Subject: Re: cleanup of linux-2.5/drivers/block/swim3.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jasper Spaans <jasper@vs19.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030704104616.GA29229@spaans.vs19.net>
References: <20030704104616.GA29229@spaans.vs19.net>
Content-Type: text/plain
Message-Id: <1057518289.516.53.camel@gaston>
Mime-Version: 1.0
Date: 06 Jul 2003 21:04:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-07-04 at 12:46, Jasper Spaans wrote:
> Hello,
>
> Attached is a patch which should solve compilation issues related to the new
> irqhandler interface, and the deprecation of cli()/sti() for the
> swim3-driver.
>
> Can you take a look, and possibly, apply this? (I don't have any hardware to
> test this on, however it compiles)

I'll take a look, but swim3 need more drastic updates for the new
BIO stuff, the new macio device interface, etc... It's on my list
once I'm done with a few other things.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
