Message-ID: <3BF911C2.C31FC6C9@mvista.com>
Date: Mon, 19 Nov 2001 08:05:54 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Howto build ppc_82xx-gcc from GNU sources ?
References: <20011119105421.1470.qmail@mailweb29.rediffmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Look at the spec file for configuration options.  The 82xx is setup by
default to optimize for the 603(EC) processor.  (Which is the core of
the 82xx processor.)

--Mark

Sarnath Kannan wrote:
>
> Hi All,
>  Whats the diff between "ppc_82xx-gcc" and the
> onee GNU provides for PPC compilation ?
> Can we build a 82xx compiler from the GCC sources ?
> Why exactly we need a seperate 82xx compiler ?
> Why not a ppC compiler ?
>
> Thanx for any help
>
> Sarnath
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
