Date: Tue, 20 Jun 2000 09:09:40 -0400 (EDT)
From: "Kevin M. Myer" <kevin_myer@iu13.k12.pa.us>
To: yellowdog-devel@lists.yellowdoglinux.com
cc: yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: dmasound module and AWACS errors
Message-ID: <Pine.LNX.4.21.0006200827480.1155-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

A little bit ago I had posted that I was having problems with sendmail
being really flaky on an otherwise (mostly) stable machine.  sendmail kept
crashing with Illegal instruction, Segmentation faults, and
Trace/breakpoint expression errors.  I have not resolved that problem and
had no reports of anyone else with similar problems so it must be
something with my hardware.

Now, I'm experiencing a phenomenon of the Windows world - random
reboots.  I go home at night with the machine running Linux and I come
to work in the morning with the machine rebooted into MacOS.  Or
sometimes, the machine is just frozen and nothing except a reboot will
bring it back.  I've noticed on several occasions that there is a problem
with the sound module.  When the dmasound module is loaded, the following
error message is logged:

AWACS error: f

although the last character fluctuates through the hex characters
available.  Just today, when I rebooted my machine and after the module
loaded, that message scrolled by forever.  I was able to login and as soon
as I unloaded the dmasound module, the message stopped displaying.

I am running Mac On Linux occasionally with the sound extension installed
so I don't know if there is something getting initialized improperly when
I boot up from MacOS into Linux via BootX or what.

I would like to get a stable box though.  Sad to say, I'm looking forward
to the day when our one x86 box is freed up and I can take over that as a
workstation :/

Hardware info:

8500/180
128Mb memory
YellowDog Linux Champion Server 1.2
Kernel 2.2.15-2.9.0 (I had tried 2.4.0-ac7 but it caused the machine to
act a little bit crazy - it would respond normally most of the time but
every few minutes, it would quit responding)
Latest RPMS are installed
1 Gb drive that is almost full

Just wondering if this is a reproducible kernel issue or if I have
defective hardware.

--
Kevin M. Myer
Systems Administrator
Lancaster-Lebanon Intermediate Unit 13
(717)-560-6140


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
