Message-ID: <3D4F06D6.3646989D@atlp.com>
Date: Mon, 05 Aug 2002 16:14:30 -0700
From: "Daniel L. Taylor" <Dan.Taylor@atlp.com>
MIME-Version: 1.0
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging kernel modules
References: <20020805230054.71397.qmail@web40207.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


apropos modules -> lsmod; man lsmod -> ksyms;
man ksyms -> "ksyms -m"

Does this help?

Brian Kuschak wrote:
>
> Wolfgang has a nice tutorial on this:
> http://www.denx.de/doc/TQM8xxL/debugging.html
>
> But here's the question - is there any way to dump the
> module load addresses, after the fact?  'insmod -m'
> works well if you always remember to use it to load
> the module.  FreeBSD has 'kldstat' which dumps module
> address information at any time.  Is there anything
> similar to kldstat for linux?  If not, any comments on
> how hard it would be to write one?
>
> -Brian
>

--
Dan.Taylor@atlp.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
