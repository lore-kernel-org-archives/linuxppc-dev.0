Message-ID: <377A65AC.BB9784E1@wanadoo.fr>
Date: Wed, 30 Jun 1999 20:45:00 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am picking this 8 weeks old thread up, because I didn't see any update
on this story. I have a couple of questions. Main question: What sources
are supposed to produce kernels working on B&W G3s?

Other form of the same question (this has been asked several times, but
I didn't see any answer, which IMHO contradicts somehow the open source
spirit): Which sources and which config options were used by the guys
who compiled the kernels for B&W G3s? 

The reason why I am asking is that I am in the process of installing
LinuxPPC on a colleague's new G3/300. After getting over all the
problems with the buggy installer others are constantly complaining
about, we have R5 fully installed and running (no accelerated X so far),
but only with the help of an old ADB keyboard.

None of the kernels available on the net recognizes the USB keyboard and
mouse of this machine! By this I don't mean the problem with French
keymaps. The keyboard and mouse just don't give *any* reaction. This
starts with the redhat installer where you have to hit some button to
say "OK" first. Impossible with this USB keyboard. Hard reboot
necessary. Needless to say that it works under MacOS. Under MacOS, you
even can use 2 keyboards and mice (ADB and USB) at the same time.

So what I would like is to compile my own kernel for this machine in
order to try to get the keyboard recognized. In the vger sources, there
is a drivers/usb directory, and after some patching of some config.in
and defconfig files, it can be compiled in (not by default). 

Question: Is this USB stuff supposed to work on Macs? I couldn't test
it, because the IDE driver in this kernel doesn't see the internal (and
only) hard disk of this machine. So it doesn't boot completely, because
the root filesystem is absent.

I saw a couple of kernel patches at yellowdog's, also for G3 IDE
drivers, but those seem to be for older kernel versions and it seems
impossible to apply them manually (I tried both 2.2.10 and 2.3.6 from
vger).

In the official R5 2.2.6 kernel sources, there is a uusb directory
containing quite different things compared to the vger drivers/usb
stuff.

Question again: Is this supposed to work on B&W G3s, and if so, with
what patches and config options? Is the IDE driver there supposed to
work on these machines?

Any help appreciated.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
