Message-ID: <3B64935B.6030309@hadess.net>
Date: Sun, 29 Jul 2001 23:51:07 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock problem
References: <20010724015531.516c9985.jpgarcia@execpc.com> <3B63877E.9060001@hadess.net> <20010729010905.3faf9642.jpgarcia@execpc.com> <3B648DC5.9050009@hadess.net> <20010729184526.B19846@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Blanton wrote:

>Bastien Nocera spake unto us the following wisdom:
>
>>So after a session of IRC, and some nasty clock problems, Joseph and I
>>(especially Joseph in fact ;) managed to get this working alright on an
>>iBook2. I attach a newer working version of keyevd that Joseph fixed
>>after my previous post, and to which I added eject (uses the eject
>>utility somewhere in your PATH).
>>
>
>Are those "clock problems" by any chance a *mean* drift?  (on the
>
mean ? not really, goes back to 1933 after each reboot...

>
>order of seconds per minute)  I had that problem, and BenH suggested
>that I comment out two lines in pmac_time.c (via_calibrate_decr () in
>an if statement and the following line).  That worked like a charm.
>
>That said, it looks like maybe he's fixed it in the 2.4.7-ben0.  I
>haven't yet tried booting it, but I see that there's an extra if
>clause that was not there before.
>Ethan
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
