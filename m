Date: Tue, 20 Jan 2004 12:06:37 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: hp <aput99@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Development Environment:
Message-ID: <20040120200637.GB32018@gate.ebshome.net>
References: <AAB0E96AD630DC4E8D751BA4D854F2A1074CB487@WKCORPXCH.corp.weekleyhomes.com> <20040120195133.50035.qmail@web20416.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040120195133.50035.qmail@web20416.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 11:51:33AM -0800, hp wrote:
> I am doing a research on what are the "best" or "most popular" tools to use
> in an embedded linux development environment right now.  I know there are a
> lot of expert embedded linux developers in this news group.  I would really
> appreciated it if you would take a few seconds to let me know what you are
> using or what you think is good to use for the following:
>
>                   compiler: _________

GCC 2.95.3 (from MVL 2.1), plan to upgrade to 3.x series shortly

>                 deployment: _________

???? what do you mean ?

> code management (i.e. cvs): _________

Perforce

>            kernel debugger: _________

BDI, RiscWatch but mostly printk + custom kernel tracer similar to LTT.

>           bootrom debugger: _________

BDI, RiscWatch

I'm not sure these are the _best_ tools though :)

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
