From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.10-ben0 doesn't see ide1
Date: Mon, 1 Oct 2001 14:28:36 +0200
Message-Id: <20011001122836.13315@smtp.adsl.oleane.com>
In-Reply-To: <20010930143946.24ad0a6b.jpgarcia@execpc.com>
References: <20010930143946.24ad0a6b.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Keyboard and trackpad no longer respond.  No logged error message.
>System doesn't seem to notice anything happened.  If I try to sleep the
>system (close the lid), it sets up, almost gets there, and aborts.
>Either something rejected the sleep request, or it did sleep but didn't
>really.  Not sure which.  rejection seems more plausable.  And if I shut
>down after an attempted sleep, the kernel panics at the last moment.  I
>had brute forced ability to ADB_RESET the bus, but that just oopsed the
>system like a sleep would.

Can you tell me more about the oops ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
