Subject: Re: Error when linking
To: manu@stapf.org
Date: Sat, 20 Oct 2001 21:26:33 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <000401c159ae$35376950$650a000a@venice> from "Emmanuel STAPF" at Oct 20, 2001 02:28:49 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011021042633.BE4EA2B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Take a look at this thread in the archives:

http://lists.linuxppc.org/linuxppc-user/199907/msg01059.html

Similar problem (90M executable), and the solution seems to
have been to use shared libraries.

Emmanuel STAPF wrote:
>
>
> Indeed my problem is supposed to be around 50MB in size and as you
> guessed I can't make it smaller.
>
> I looked at the mailing list archive but I could not find what I should
> use to make `ld' link my object files. So if anyone as the solution do
> not hesitate to share it.
>
> Thanks,
> Manu
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
