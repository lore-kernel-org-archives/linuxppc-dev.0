Date: Wed, 7 Feb 2001 23:45:51 -0800 (PST)
From: William Blew <wblew@home.com>
To: Tim Moloney <moloney@mrsl.com>
cc: <linuxppc-dev@lists.linuxppc.org>,
        <yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: Accessing global symbols from shared library
In-Reply-To: <00cc01c0913a$7d647480$6c125acf@mrsl.com>
Message-ID: <Pine.LNX.4.30.0102072345240.5464-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Feb 2001, Tim Moloney wrote:

I suggest taking a look at the implementation of the X server. It achieves
such a feat routinely.

> I am currently trying to port a Solaris application to Linux.  The
> Solaris application dynamically loads custom shared libraries which
> can access symbols in the main executable.  This is not a clean
> design, but it works.  From what I've seen so far, the Linux
> runtime loader does not allow a shared library to access symbols in
> the main executable.
>
> If someone knows of a linker switch or something that allows shared
> libraries to access global symbols, please let me know.
>
> Tim Moloney
>
> ManTech Real-time Systems Laboratory
> 2015 Cattlemen Road
> Sarasota, FL  34232
> (941) 377-6775 x208
>
>
>

--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
