Message-ID: <003d01c091de$4d504f90$6c125acf@mrsl.com>
From: "Tim Moloney" <moloney@mrsl.com>
To: "William Blew" <wblew@home.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>
References: <Pine.LNX.4.30.0102072345240.5464-100000@apollo.kulian.net>
Subject: Re: [solved] Accessing global symbols from shared library
Date: Thu, 8 Feb 2001 09:49:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the response.

After rereading the ld man page, I discovered the -export-dynamic
switch which does exactly what I want.  I was either blind or
confused the first time I read the ld man page.

Thanks again.

Tim Moloney

ManTech Real-time Systems Laboratory
2015 Cattlemen Road
Sarasota, FL  34232
(941) 377-6775 x208

----- Original Message -----
From: "William Blew" <wblew@home.com>
To: "Tim Moloney" <moloney@mrsl.com>
Cc: <linuxppc-dev@lists.linuxppc.org>;
<yellowdog-devel@lists.yellowdoglinux.com>
Sent: Thursday, February 08, 2001 2:45 AM
Subject: Re: Accessing global symbols from shared library


> On Wed, 7 Feb 2001, Tim Moloney wrote:
>
> I suggest taking a look at the implementation of the X server. It
achieves
> such a feat routinely.
>
> > I am currently trying to port a Solaris application to Linux.  The
> > Solaris application dynamically loads custom shared libraries which
> > can access symbols in the main executable.  This is not a clean
> > design, but it works.  From what I've seen so far, the Linux
> > runtime loader does not allow a shared library to access symbols in
> > the main executable.
> >
> > If someone knows of a linker switch or something that allows shared
> > libraries to access global symbols, please let me know.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
