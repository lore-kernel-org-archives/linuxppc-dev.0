Subject: Re: Is there a specific Alan Cox series 2.4.X I should grab for ppc
	linux?
From: Keith Clayton <keith@claytons.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011008135743.ZSR8090.tomts16-srv.bellnexxia.net@there>
References: <20011008135743.ZSR8090.tomts16-srv.bellnexxia.net@there>
Date: 08 Oct 2001 07:31:35 -0700
Message-Id: <1002551501.952.6.camel@yoda>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

I tried 2.4.10 from kernel.org and it would lock hard once I needed VM.
I just compiled 2.4.10-ac8 this morning and so far so good.  I've got
112Mb on my machine and (conveniently enough) can run GNOME plus a few
apps before hitting swap.  So I took it right to the edge of physical
memory and then started Mozilla.  No problems.  With 2.4.10 (kernel.org)
this was certain death.

Previously I had 2.4.6 running which worked but would get very slow when
swapping.  Abnormally slow.  (Mouse would freeze temporarily while
swapping).  Not seeing that behavior so far.

Hope that helps a bit.  Not exactly a battle-tested kernel or anything
but so far I find 2.4.10-ac8 to be an improvement over <=2.4.6

Cheers,
Keith

On Mon, 2001-10-08 at 06:59, Kevin B. Hendricks wrote:
>
> Hi,
>
> I really need to get 2.4.X stable on my machine.  Dan recommends the Alan
> Cox series of 2.4.X if I am having VM trouble.
>
> Is there a specific ppc linux tree I should grab to get Alan's latest with
> ppc specific added or should I just go grab his latest direct from his
> site?
>
> Thanks,
>
> Kevin
>
>
--
<><><><><><><><><><><><>
Keith Clayton
keith@claytons.org

"If you don't trust me with your source code,
            why should I trust you with my computer?"

Just say no to police states . . encrypt your email

GPG key: http://home.pacbell.net/clay-ton/keith_public_key.html
         http://www.keyserver.net

GPG fingerprint: 33FF 1D80 4562 1600 4BAB  5018 BCB7 635C B0CC 99EE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
