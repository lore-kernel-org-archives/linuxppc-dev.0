Return-Path: <mohanreddykv@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110118175533.GB28268@opentech.at>
References: <AANLkTinSfn+TQvzNWc++qP=4B2tbcHo-2iGv6E8tsq+b@mail.gmail.com>
	<20110118175533.GB28268@opentech.at>
Date: Wed, 19 Jan 2011 00:06:04 -0500
Message-ID: <AANLkTinDsQYS=dHM2EVbCxv0Yk2zVq5LrYJemL6nSn3D@mail.gmail.com>
Subject: Re: Problem with Busybox shell
From: MohanReddy koppula <mohanreddykv@gmail.com>
To: Nicholas Mc Guire <der.herr@hofr.at>, Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

But, if there is any problem with cable I could not have seen any
character in the interrupt routine of the driver. I turned off both
software and hardware flow control as by board doesn't have hardware
flow control. tty_read is called and it hangs at ldisc->read. And I
see that data is put into the tty buffer by the driver. Will there be
any problem with copy_to_user() if there is some problem in the
memory?

Thanks,
Mohan

On Tue, Jan 18, 2011 at 12:55 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Tue, 18 Jan 2011, MohanReddy koppula wrote:
>
>> Hi All,
>>
>> I am working on an MPC885 based custom board. I am able to boot up the
>> linux (linux-2.6.33.7). I could see busybox shell (ash) prompt. But it
>> is not accepting any inputs, I am not able to enter any command, it
>> just hangs there. I am using ttyCPM0 terminal.
>>
>> I suspected if there was any problem in CPM driver interrupts
>> generation and put some printk's in the interrupt handler and could
>> see interrupts are raised and data is read, but shell is not taking
>> the input.
>>
>> I wrote an init.c and opened the ttyCPM0 and tried to read from it,
>> but couldn't. I am able to write to ttyCPM0 and see it on the host
>> minicom.
>>
> if you are using minicom to connect check if you have hardware/software flow
> control turned on - it also could be a cabling problem - had this with the
> beagle board where the tx line was on the wrong pin - so I got output but
> could not get any response to input.
>
> hofrat
>
>
