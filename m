Date: Tue, 20 Jan 2004 19:38:14 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew May <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Small UDP packet performance
Message-ID: <20040121033814.GC3905@gate.ebshome.net>
References: <00b101c3de3e$9c34f200$9104050a@JACKYLAM> <20040119052806.GA26841@gate.ebshome.net> <015501c3deef$27263030$9104050a@JACKYLAM> <20040120010227.GA32018@gate.ebshome.net> <20040120232342.GA20399@acmay.homeip.net> <20040121011650.GA3905@gate.ebshome.net> <20040121020501.GA22956@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040121020501.GA22956@acmay.homeip.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 06:05:01PM -0800, Andrew May wrote:
> > Looks OK, although I chose another way to disable RX IRQs :)
>
> Do tell.

I don't set I bit in RX BD, and I use MALx_CFG[EOPIE] do
enable/disable end-of-packet IRQ generation.

> The most important
> thing is that when the input rate goes higher the output stays at
> the max instead of going down.

Yeah, that's definetely is the goal :).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
