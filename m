From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eaden McKee <eaden@webtec.co.nz>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Screen stays on in sleep mode (round ibook)
Date: Sat, 6 Apr 2002 12:52:39 +0200
Message-Id: <20020406105239.766@smtp.wanadoo.fr>
In-Reply-To: <1018031780.582.6.camel@LiMac>
References: <1018031780.582.6.camel@LiMac>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I reported this on debianppc, but was told to bring it here.
>I am using 2.4.19-pre5-ben0 from ppckernels.org, and when I shut the
>lid, or it times out and goes into sleep mode, The sleep light is
>flashing, but the screen stays on.It is a 300mhz blueberry round ibook.
>Please CC to me as I am not subscribed.

You are probably not using the atyfb or aty128fb video driver. Make
sure you have them compiled in your kernel and that you don't have
"novideo" (or video=ofonly) in your yaboot.conf.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
