Date: Wed, 15 Mar 2000 15:49:21 +0100 (MET)
From: Christiaan Welvaart <C.J.Welvaart@phys.uu.nl>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.51 Trashes RTC on Beige G3 Mini-tower
In-Reply-To: <200003141133.LAA09460@hyperion.valhalla.net>
Message-ID: <Pine.OSF.4.21.0003151519190.20168-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Mar 2000, Iain Sandoe wrote:

> at boot time {with options vmode=atyfb, vmode:16,code:32 single }
> the usual "rtc time is" ... prints the correct date...
> then we get "setting time to ... some time in Feb 1932...
> from then on the RTC is wrong although using 'date' to set the correct time
> behaves as expected on the running system.
> Is this a library problem? (I'm using 2.3.51 with a system installed from
> linuxPPC Q3 - but I've also updated to glibc-2.1.3 - j).

On a beige G3 Dekstop, with the standard 2.3.51 sources, I don't see this
problem At least there are no wrong dates set in /var/messages, though I
only booted 2.3.51 twice. I use glibc-2.1.3-4a (with linux 2.2.14 now).

I did find a different problem: the builtin ethernet port doesn't work. It
seems to work (almost?) perfectly from within linux (i.e. no errors), but
no ethernet connection is made. The light on the hub stays off while the
kernel reports that BMAC ethernet was succesfully initialized.


    Christiaan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
