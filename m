Return-Path: <scottwood@freescale.com>
Date: Tue, 18 Jan 2011 14:59:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: MohanReddy koppula <mohanreddykv@gmail.com>
Subject: Re: Problem with Busybox shell
Message-ID: <20110118145931.00957731@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTinSfn+TQvzNWc++qP=4B2tbcHo-2iGv6E8tsq+b@mail.gmail.com>
References: <AANLkTinSfn+TQvzNWc++qP=4B2tbcHo-2iGv6E8tsq+b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Jan 2011 07:54:42 -0500
MohanReddy koppula <mohanreddykv@gmail.com> wrote:

> Hi All,
> 
> I am working on an MPC885 based custom board. I am able to boot up the
> linux (linux-2.6.33.7). I could see busybox shell (ash) prompt. But it
> is not accepting any inputs, I am not able to enter any command, it
> just hangs there. I am using ttyCPM0 terminal.
> 
> I suspected if there was any problem in CPM driver interrupts
> generation and put some printk's in the interrupt handler and could
> see interrupts are raised and data is read, but shell is not taking
> the input.
> 
> I wrote an init.c and opened the ttyCPM0 and tried to read from it,
> but couldn't. I am able to write to ttyCPM0 and see it on the host
> minicom.
> 
> Please some one help me.

Check your pin and clock setup -- perhaps tx is set up correctly but rx
isn't.

-Scott
