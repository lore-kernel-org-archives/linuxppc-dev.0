Message-ID: <384FF57D.550C9514@pop.agri.ch>
Date: Thu, 09 Dec 1999 19:31:44 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Gary Thomas <gdt@linuxppc.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mozilla preM12 ppc rpms...
References: <XFMail.991209110250.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Gary Thomas wrote:
> 
> On 09-Dec-99 Ani Joshi wrote:
> >
> >
> > I have placed a preM12 snapshot at
> >
> > ftp://devel.linuxppc.org/users/ajoshi/{RPMS,SRPMS}
> >
> > This build includes Franz Sirl's XPTCall port.
> > Please let me know how it well it fares for everyone as we have not
> > tested it much.
> >
> 
> Where can I find all of the required pieces?
> 
> [root@icarus gary]# rpm -ivUh /tmp/mozilla-5.0-M11.ppc.rpm
> error: failed dependencies:
>         glibc >= 2.1.3-0h is needed by mozilla-5.0-M11
>         libIDL-0.6.so.0 is needed by mozilla-5.0-M11
>         libgtkmozilla.so.0 is needed by mozilla-5.0-M11
>         libstdc++-libc6.1-2.so.3 is needed by mozilla-5.0-M11
>         libc.so.6(GLIBC_2.1.3) is needed by mozilla-5.0-M11

at least the libc stuff you can find under the address above with
fsirl/R5/RPMS iso ajoshi 

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
