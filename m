From: tom_gall@vnet.ibm.com
Message-ID: <397D9744.31E6BDC6@vnet.ibm.com>
Date: Tue, 25 Jul 2000 13:33:56 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
References: <200007250345.VAA22028@faith.cs.utah.edu> <397D926F.111AF60E@ivey.uwo.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:
>
> Hi Godmar,
>
> > Is the stack alignment code 64bit safe?
>
> As promised, here is the clean up patch.  It should be applied after my first
> patch.
>
> The only assumption I am making here is that sizeof(unsigned int) = sizeof(void
> *).

> This should be true on both 64 bit and 32 bit systems.

Hi Kevin,

  This is only true as far as the 64 bit systems running on the 32 bit kernel,
which is all there is at the moment.

  Work has started on the 64 bit PowerPC Linux kernel, if Kaffe is compiled as a
64 bit app for that kernel then sizeof(unsigned long) = sizeof(void *) will be
true. Certainly not a big deal at this stage, but thought you'd be interested
none the less.

  Regards,

  Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
