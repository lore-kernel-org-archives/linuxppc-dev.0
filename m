Date: Mon, 2 Aug 2004 06:57:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Daren Hayward <darenh@4bridgeworks.com>
Cc: "'Matt Porter'" <mporter@kernel.crashing.org>,
	"'Ralph Siemsen'" <rsiemsen@rossvideo.com>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: early UART mapping in head_44x.S
Message-ID: <20040802065752.A28244@home.com>
References: <C18BA5DDB58DD511BD0700C0DF0DD45011C475@NTSERVER4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD45011C475@NTSERVER4>; from darenh@4bridgeworks.com on Mon, Aug 02, 2004 at 01:30:10PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 02, 2004 at 01:30:10PM +0100, Daren Hayward wrote:
>
> Hi,
>
> I have been having the same problems with the head_44x.S, what does the
> patch do just remove the duplicate entries?

Yes, it removes the repeated code.

> Where can I browse the PPC BK tree online?

Most PPC subarches don't use the old linuxppc-2.5 tree any longer.
The latest 4xx bit are in mainline.

http://linux.bkbits.net:8080/linux-2.5

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
