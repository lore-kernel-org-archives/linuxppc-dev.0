Date: Sun, 8 Feb 2004 20:10:41 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: JACK HWAN <jhfami@yahoo.co.kr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting time
Message-ID: <20040209041041.GA3901@gate.ebshome.net>
References: <20040209013945.68409.qmail@web21506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040209013945.68409.qmail@web21506.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 09, 2004 at 10:39:45AM +0900, JACK HWAN wrote:
>
> Hi.
>  I ported linux-2.4.x to my motorola ppc8xx custom
> board. And it works quite
> well.
> But the problem is booting time. It cosume too much
> time than other embedded
> OSes.
> I disabled all options that I can. But it still slow.
>  I took about 15~16 sec. the others are only takes
> about 8 sec.
>  How can I reduce the booting time?

Try turning off serial system console.

Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
