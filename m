Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: "'Mailing List: linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>,
	<rodmur@maybe.org>
Subject: RE: A question on kernel clock: 
Date: Wed, 31 Dec 2003 10:44:46 +0800
Message-ID: <000001c3cf48$0e4b80d0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20031230184951.94F07C12DD@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks a lot!

I means nanosleep() function.

Best Regards,
John

> (1) which timer is used for nsleep?

> I have not the slightest idea. I don't know of any  standard  funtion
> with that name - neither in user space nor in kernel code.


-----Original Message-----
From: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Wolfgang Denk
Sent: Wednesday, December 31, 2003 2:50 AM
To: zjzhou@newrocktech.com
Cc: 'Mailing List: linuxppc-dev'
Subject: Re: A question on kernel clock:



Dear John,

in message <000501c3cec2$130dbab0$b702a8c0@newrock2> you wrote:
>
> The processor I mentioned is MPC82xx. Now, I have kernel from kernel.org

[I guessed that from the ...BRG8 part.]

> run on the board. But, my "nsleep()" is not exactly. So, I want to
> realize the timer mechanism of Linux used.

> (1) which timer is used for nsleep?

I have not the slightest idea. I don't know of any  standard  funtion
with that name - neither in user space nor in kernel code.

> (2) can udelay() be changed to be preempted by other process?

That makes little sense. If you allow to run other prcesses inbetween
you will have  looong  delays  -  udelay()  was  not  made  for  such
purposes,  but  for  very  short delays (as the name suggests: in the
range of a few microseconds).

> (3) which is good choice for Kernel timeslice?

What's wrong with the standard 10 ms ?

> Additional, could we develop a bootloader like vxworks' bootloader? (
> vxworks bootloader is a little vxworks, I think.)

Of course you can. But what for? If you like the VxWorks boot loader,
then use it. If you like something more powerful, use U-Boot.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
This all sounds complicated, but it mostly does excatly what you  ex-
pect. It's just difficult for us to explain what you expect...
                       - L. Wall & R. L. Schwartz, _Programming Perl_


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
