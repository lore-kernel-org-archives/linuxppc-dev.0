Date: Thu, 11 Oct 2001 09:12:26 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Stefan Wanner <stefan.wanner@ymail.ch>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: vfat on bigendian
In-Reply-To: <3BC5AE61.5060700@ymail.ch>
Message-ID: <Pine.LNX.4.33.0110110911320.7496-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Oct 2001, Stefan Wanner wrote:

> i tried the patch you posted today:
> http://lists.linuxppc.org/linuxppc-dev/200110/msg00075.html
>
> now, i can read files with long names created on windows. but it's no
> more possible to create files on the linux system (also 8.3 names). they
> apear on linux as ????.

*self-baps* Doh. I see where I need to add another translation, and I'm
doing so now.

/me == idiot...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
