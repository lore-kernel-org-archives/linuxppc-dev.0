Date: Mon, 19 Jan 2004 17:02:27 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Small UDP packet performance
Message-ID: <20040120010227.GA32018@gate.ebshome.net>
References: <00b101c3de3e$9c34f200$9104050a@JACKYLAM> <20040119052806.GA26841@gate.ebshome.net> <015501c3deef$27263030$9104050a@JACKYLAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <015501c3deef$27263030$9104050a@JACKYLAM>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 08:48:38AM +0800, Jacky Lam wrote:
>
>     Thanks. My case is that I am using NetPerf to test the UDP performance.
> I am using a x86 with GigaEthernet card and sending packet to my 405EP in
> full speed. I find that the box nearly dead in first min and lost all
> packets. I know that it is unavoidable. But I want to know anyway to improve
> as much as possible.
>
>     What is NAPI? How can I make use of it?

Please, use google as I suggested and you find good discussion of the
problem you are experiencing.

Right now, there is no publicly available NAPI-enabled  driver for
4xx, although I have something done in that direction, but unfortunately
I put this task on hold because of more urgent problems :( (maybe I'll
return to it this or next month)

> Is there any buffer size in UDP stack that I can adjust?

No, it has nothing to do with UDP socket buffer size.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
