Message-ID: <38500919.3E4E715@wanadoo.fr>
Date: Thu, 09 Dec 1999 20:55:05 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: Gary Thomas <gdt@linuxppc.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Mozilla preM12 ppc rpms...
References: <Pine.LNX.4.10.9912091055550.24792-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ani Joshi wrote:
> 
> On Thu, 9 Dec 1999, Gary Thomas wrote:
> 
> > Where can I find all of the required pieces?
 
> >         libc.so.6(GLIBC_2.1.3) is needed by mozilla-5.0-M11
> 
> glibc-2.1.3 ofcourse

'cept that glibc-2.1.3-0h does not provide libc.so.6(GLIBC_2.1.3). Guess
you need glibc-2.1.3-0j.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
