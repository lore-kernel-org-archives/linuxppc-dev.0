From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200305060601.h4661IF16811@hofr.at>
Subject: Re: Linux Kernel generic question (procedure queue)
In-Reply-To: <20030506064428.74357.qmail@web9704.mail.yahoo.com> from None Atall
 at "May 5, 2003 11:44:28 pm"
To: None Atall <linux_meis@yahoo.com>
Date: Tue, 6 May 2003 08:01:18 +0200 (CEST)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>  Hello everybody,
>  Is it possible to insert
> a specific procedure (among with it's args) to the
> kernel scheduler? I know that we can just call
> schedule(); when we wait for an asychronus input or
> we can even insert an interrupt to the kernel queue,
> but is it possible to queue a procedure?

not realy the same effect but you could use a tasklet and call
tasklet_schedule(&write_byte_tasklet);
where the  write_bytee tasklet is nothing else but your write_byte function.

>  Just for understanding the problem better, I have
> a function write_buff that calls write_byte.
> Write_byte
> function uses PPC gpio for implementing something like
> an SPI interface. When we write a big file (e.x 1M),
> the system will not respond to anything until the
> transfer is done. I inserted "schedule();" every time
> the write_byte is called so that the system will
> accually perform some other tasks. So my question is
> if I could insert write_byte function to the scheduler
> queue in such a way to prevent this problem.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
