Message-ID: <20020806024322.41175.qmail@web40204.mail.yahoo.com>
Date: Mon, 5 Aug 2002 19:43:22 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: debugging kernel modules
To: "Daniel L. Taylor" <Dan.Taylor@atlp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D4F06D6.3646989D@atlp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Dan, I think that's it.  With a little bit of
scripting I should be able to make it work nicely.


--- "Daniel L. Taylor" <Dan.Taylor@atlp.com> wrote:
> apropos modules -> lsmod; man lsmod -> ksyms;
> man ksyms -> "ksyms -m"
>
> Does this help?
>
> Brian Kuschak wrote:
> >
> > Wolfgang has a nice tutorial on this:
> > http://www.denx.de/doc/TQM8xxL/debugging.html
> >
> > But here's the question - is there any way to dump
> the
> > module load addresses, after the fact?  'insmod
> -m'
> > works well if you always remember to use it to
> load
> > the module.  FreeBSD has 'kldstat' which dumps
> module
> > address information at any time.  Is there
> anything
> > similar to kldstat for linux?  If not, any
> comments on
> > how hard it would be to write one?
> >
> > -Brian
> >
>
> --
> Dan.Taylor@atlp.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
