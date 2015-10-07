Return-Path: <geoff@infradead.org>
Message-ID: <1444238423.29301.16.camel@infradead.org>
Subject: Re: Time to remove platforms/cell?
From: Geoff Levand <geoff@infradead.org>
To: Marc Dietrich <marvin24@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org
Date: Wed, 07 Oct 2015 10:20:23 -0700
In-Reply-To: <2232594.bcXLTZgZyv@fb07-iapwap2>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2785247.ZjG8XMQlJP@fb07-iapwap2> <1443986839.20459.8.camel@infradead.org>
 <2232594.bcXLTZgZyv@fb07-iapwap2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-10-05 at 12:27 +0200, Marc Dietrich wrote:
> Am Sonntag, 4. Oktober 2015, 12:27:19 schrieb Geoff Levand:
> > I just tested the ps3-queue branch (v4.3-rc4 based) of my ps3-linux
> > git
> > repo and it works OK.
> > 
> > Do you see any output on the display, maybe some penguins at least
> 
> 
> I tried with ps3-queue and still no luck. Petitboot just says
> "Booting kernel 
> ..." thats all - no output.
> 
> FW is 3.15 of course
> Petitboot says (white-09.09.01-15.56)
> compiled kernel with gcc 4.4.2 (fedora 13)
> git clean -fdx; make ps3_defconfig; make vmlinux modules; make
> modules_install
> strip --strip-unneeded vmlinux

I think I can reproduce your problem, but didn't have time to look into
it.  I'll try to find time over the weekend.

If you want to try some things yourself, one is to exit to the
petitboot shell and try a manual kexec from there to see if there are
any messages that might explain what's going wrong.  Another is to use
git bisect to try to locate the kernel commit that introduced the
problem.  Let me know anything you find if you try.

-Geoff
