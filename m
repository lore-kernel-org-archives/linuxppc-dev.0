Date: Thu, 3 Jun 1999 21:27:35 -0700 (PDT)
From: Matt McLean <keys@yikes.com>
To: Patrik Jonsson <patrik@ucolick.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with linux/in.h
In-Reply-To: <Pine.GSO.4.03.9906032056170.28081-100000@isis.ucolick.org>
Message-ID: <Pine.BSF.4.01.9906032124140.29773-100000@brio.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Jun 1999, Patrik Jonsson wrote:

> 
> Hi all,
> When I try to compile code that uses networking (I tried ssh and freeciv) 
> I get this error:
> 
> In file included from /usr/include/netinet/in.h:27,
>                  from packets.c:19:
> /usr/include/linux/in.h:109: parse error before `sa_family_t'
> /usr/include/linux/in.h:109: warning: no semicolon at end of struct or
> union
> /usr/include/linux/in.h:116: parse error before `}'

This sounds like a very old compatibility problem with the older GNU libc
that came with R4[.1].  I recommend updating to the latest pre-R5.

-matt


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
