Message-ID: <38441203.7183CD88@eecs.lehigh.edu>
Date: Tue, 30 Nov 1999 13:05:55 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and
	  gcc-2.95.2
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
Content-Type: text/plain; charset=iso-2022-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 1. this behaviour is mandated by the ABI

Hmm. I just checked the SYSVR4 ABI, and indeed it lists va_list as a typedef of
1 element array. Oh well. But I notice that va-ppc.h does not define 
void *__va_arg(va_list argp, _va_arg_list_type type) which is *required* by the
same ABI <grin>

Do I smell a bug ?? ;)

> 2. it nicely spots a common programming error

Yes, but only in one assignment direction. In any case, it caught the error on
ssh, and I'll post LinuxPPC specific patches to ssh-2.0.13 soonish.

-jason

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
