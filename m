Date: Mon, 15 Jan 2001 22:56:10 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: setting the frequency on an airport card?
Message-ID: <20010115225610.A11116@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010115212843.A10256@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010115212843.A10256@wibble.net>; from sjh@svana.org on Mon, Jan 15, 2001 at 09:28:43PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 15, 2001 at 09:28:43PM +1100, Steven Hanley wrote:
>
> The aiport.c contains
> if ((port_type != 3) || (wrq->u.freq.m > 1000) || (wrq->u.freq.e > 0))
>    rc = -EOPNOTSUPP;

I must be in stupid mode today or something, I looked at this for a minute
or two and suddenly wondered, what hte heck is that port_type thing, of
course a quick glance at the top of the file shows it is a module paramater,
so when I set it on modporbe or insmode on both machines suddenly I can use
the ioctls, duh, anyway I will probably put this up on a web page or some
such in the next day or so (my how to get this running page) as it was not
exactly obvious to me and I didnt see mention of the port type paramater (I
suppose airports and their clients are usually managed)

Anyway happy now :)

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
