Message-ID: <393EAB25.CED7826B@grn.georet.net>
Date: Wed, 07 Jun 2000 16:05:58 -0400
From: Ryan Boder <rboder@grn.georet.net>
Reply-To: rboder@grn.georet.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 configuration
References: <393D6256.89D44EA6@grn.georet.net> <393D7854.8CF53542@erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nelson Abramson wrote:
>
> Ryan Boder wrote:
>
> > Does anyone have a .config to configure a kernel that is stable on the
> > G4 sawtooth? I have the current stable source but every kernel I compile
> > freezes and corrupts my root file system. If anyone has one will you
> > please mail it to me?
>
> The .config that comes with Paul's tree (via rsync) should compile and run
> your sawtooth just fine.  It worked for me...
>
> If you are using that one and still having problems, you may want to do
> some more investigation.
>
> HTH
> --Nelson Abramson
>


I have tried the regular defconfig that comes with tree. With that one
it said kernel stack overflow when I was booting. Then I tried the
pmac_defconfig and it said that the pc had reached memory out of bounds.
Finally I took the defconfig from ben H's 2.2.15pre3 kernel and went
through the whole make config process using ben's config as a guide. The
kernel I got out of this booted successfully but as soon as I logged in
it said kernel stack overflow and froze up. I know that Ben's
configuartion works because I am using his kernel right now. So I am at
a loss as to why I can't compile a kernel that works. I just rsynced the
source right before I tried these so it is about as new as possible.

If anyone has figured this out before or has any ideas what's causing
the stack overflow let me know. Thanks.
-Ryan


> --
> "Apparently if you play the Windows NT CD backwards you hear satanic messages"
> "You think that's bad, if you play it forwards it installs Windows NT!"
> --orlando

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
