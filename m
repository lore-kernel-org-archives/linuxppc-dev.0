Message-Id: <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 13:24:21 -0700
To: Eugene Surovegin <ebs@ebshome.net>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040519210438.GA13351@gate.ebshome.net>
References: <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Eugene.

Actually, I had no intention of trying to port ebony to u-boot.  I just wanted
to get something to work.

Unfortunately, we've had no luck getting it to boot with the default ibm
bootloader either.



At 02:04 PM 5/19/04 -0700, Eugene Surovegin wrote:
>On Wed, May 19, 2004 at 12:36:50PM -0700, Brian Hawley wrote:
> >
> > At 09:54 PM 5/19/04 +0200, Wolfgang Denk wrote:
>
>It's arch/ppc/platforms/4xx/ebony.[ch]
>
>And no, ebony.[ch] doesn't support u-boot. So it cannot work with u-boot
>if you
>didn't change ebony.[ch].
>
>You cannot just substitute boot loader without changing board support in
>Linux
>kernel and expect it to work.
>
>.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
