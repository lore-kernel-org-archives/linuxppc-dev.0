Date: Tue, 19 Oct 1999 11:07:36 -0700
From: "David N. Welton" <davidw@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel questions
Message-ID: <19991019110736.A21986@bassano.linuxcare.com>
References: <19991018121353.D17058@bassano.linuxcare.com> <Pine.LNX.4.05.9910191836220.28274-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9910191836220.28274-100000@callisto.of.borg>; from Geert Uytterhoeven on Tue, Oct 19, 1999 at 06:36:49PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 19, 1999 at 06:36:49PM +0200, Geert Uytterhoeven wrote:

> > > Yes, it's correct. However, I beleive the kernel is compiled to boot
> > > on CHRP _and_ PowerMacs, and so the ADB support is needed. Also, the
> > > CHRP definition states that CHRP machines can have an ADB controller
> > > too.

> > I'm compiling as CHRP, and since ADB is selectable as an option, it
> > seems it could be added in anyway, pmac or not?

> > So would it be a worthwhile endeavour to try and ifdef this stuff out,
> > for those of us who don't need it?

> Isn't that already done in the latest 2.3.x?

I'm working with 2.3.22, and it hasn't been done, afaict.

Thanks,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
dwelton@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
