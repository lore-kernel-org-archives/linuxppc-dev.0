Date: Fri, 21 May 1999 10:15:12 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Derek Moeller <moeller@networksplus.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Diald Compilation problems
In-Reply-To: <Pine.LNX.3.96.990520183808.529A-100000@ns1.networksplus.net>
Message-ID: <Pine.LNX.3.96L.990521101250.1510A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 May 1999, Derek Moeller wrote:
> 
> 	I've been having problems compiling the Diald package for
> LinuxPPC/4.1/iMac. Make gives up after complaining about many different
> errors.  Unfortunately, there is no precompiled rpm avaible that I have
> seen. Has anyone had success compiling this package, or is there a
> different one that accomplishes similar? 
> 	BTW, during make depend it gives me a few warnings.
> 
> cc -E -M *.c > .depend
> firewall.c:51: warning: `#ifdef' argument starts with a digit
> firewall.c:58: warning: `#ifdef' argument starts with a digit
> firewall.c:547: warning: `#ifdef' argument starts with a digit
> firewall.c:579: warning: `#ifdef' argument starts with a digit
> firewall.c:598: warning: `#ifdef' argument starts with a digit
> ppp.c:11: warning: `#ifdef' argument starts with a digit
> 	
> 	The #ifdef's mentioned to have a digit (0) right after the
> argument. I don't know why it's choking on this, though.
> 	Thanks...

The compiler might not like that. I know CC on SGI doesn't... try making it
'#if 0' rather than '#ifdef 0'. Although I guess that won't let you compile...

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
