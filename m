From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linux-usb@suse.com>
Cc: "Dunlap, Randy" <randy.dunlap@intel.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-usb] USB problems on Lombard Powerbook ... and more
Date: Thu, 20 Apr 2000 16:27:31 +0200
Message-Id: <20000420142732.6194@mailhost.mipsys.com>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F0545CA3E@orsmsx31.jf.intel.com>
References: <D5E932F578EBD111AC3F00A0C96B1E6F0545CA3E@orsmsx31.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 19, 2000, Dunlap, Randy <randy.dunlap@intel.com> wrote:

>> (kernel 2.2.15pre17 compiles fine, with usb modules. I think
>> the kernel I am using
>> has a USB backport coming from 2.3. Actually I got these sources from
>> linuxcare - see point 2)
>
>Some things below make me think that whatever you have
>is not very recent, so the Linux USB Guide and
>current email threads don't necessarily apply to your
>USB source code.

The "current" stable kernel used on PowerMacs is Paul Mackerras tree and
contains an old backport of the 2.3.x USB stack (one of the last version
to use Greg old ohci.c driver). We use it because it's stable and appear
to work fine with keyboards and mice on all macs out there. That mean
that machines with USB-only kbds and mice could at least be used, which
was a progress over previous stacks ;)

However, it's definitely not complete enough to be used for anything
else. (Well, a few drivers actually work, but that's not the point).

The recent 2.3.x stack appear to work quite well on macs too, now that
the biggest OHCI problems were ironed out, but has not yet been
"tortured" enough for us to backport it into our stable 2.2.x series.

>Yes (centralized).  Yes (several wandering around).
>Linus maintains the blessed tree for all architectures.
>Development trees can and do also exist elsewhere,
>like PPC, Sparc, ARM, etc.  They will eventually get merged
>back into the Linus tree.

In the case of the macs, we have a quite huge batch of changes that has
not been merged in the 2.2.x tree yet, mostly because those changes (that
concern new machines support) were finished too late for inclusing in
2.2.14, and Alan wants only bug fixes in 2.2.15.
Also, since we use this weird USB backport that may never end up in the
"official" 2.2.x series, PowerMac users usually rely on kenrels
maintained by Paul Mackerras (who is _the_ maintainer of the PowerMac port).

For 2.3.x series, the work is done on our "specific" PPC trees (Paul's
tree and hq.fsmlabs.com bitkeeper tree) and regulary merged in Linus main
one. Ideally, when 2.4 is final, all the PowerMac specific stuffs will be
up-to-date.

For more infos about PowerMac kernels, one can consult Paul's page at:

http://linuxcare.com.au/paulus/kernels.html


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
