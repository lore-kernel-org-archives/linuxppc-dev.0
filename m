Message-ID: <387ECAA5.CBBCBC2C@mandrakesoft.com>
Date: Fri, 14 Jan 2000 02:05:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: Andreas Tobler <toa@pop.agri.ch>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.39 compiles & boot
References: <387D067A.50942911@pop.agri.ch> <00011313582505.00484@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> 
> On Thu, 13 Jan 2000, Andreas Tobler wrote:
> 
> > may some of you are as far as I am, otherwise here is the diff I had to
> > do to get a 2.3.39-linus-tree to compile & boot with a Wallstreet I.
> > hope to ok otherwise let me please know.
> 
> I think this patch is not quite the best way to do it.  We already had
> 32-bit uids so we don't need the compatibility crap.  Here is a patch that
> fixes the compile (alternatively my linux-pmac-devel rsync tree has a
> 2.3.39 tree that compiles and works).

Take a look at 2.3.40-pre2.  It includes my uid16 fixes to the core and
to the Alpha arch.  The Alpha didn't need the 16-bit compatibility mess
either.

CONFIG_UID16 is now the define to test...  I simply added "define_bool
CONFIG_UID16 n" to arch/alpha/config.in, just to make it plain that the
compatibility stuff was not wanted.

Regards,

	Jeff




-- 
Jeff Garzik         | Demotivator of the month:  MISTAKES
Building 1024       | It Could Be That The Purpose Of Your Life
MandrakeSoft, Inc.  | Is Only To Serve As A Warning For Others.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
