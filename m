From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Emerson <cemerson@chiark.greenend.org.uk>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
Date: Fri, 19 Jan 2001 23:59:58 +0100
Message-Id: <19341214163142.29221@mailhost.mipsys.com>
In-Reply-To: <14952.48929.34769.196323@chiark.greenend.org.uk>
References: <14952.48929.34769.196323@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>[dri-devel removed]
>
>On Friday, 19 Jan 2001, Benjamin Herrenschmidt wrote:
>
>[requirements for prom_print() and xmon_printf()]
>[snip]
>>  - The same video mode/depth current than the one you had when it
>> booted.
>
>Does that mean the mode/depth set by OF, or the one set by the vmode
>kernel cmdline option?

The one set by OF. If the video driver supports it (that should be the
case of most drivers used on ppc with 2.4), any video mode set either via
cmdline, fbset, etc... or X if X is using fbdev's.

>Is it possible to use xmon on a G4 (350MHz AGP) without one of these
>stealth serial ports?  I don't currently do enough kernel debugging to
>really make it worth getting one along with the necessary cables to
>plug something into it.

With a cable from the G4's modem to another modem, and some hackery
(already present in arch/ppc/xmon/start.c, I suggest you look at that
file), it's possible but tricky.

>I'm currently running 2.4.1pre7 rsynced from the bk tree.

pre8 is already there ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
