Message-ID: <3C0D53A4.E6A2F0DD@folkwang-hochschule.de>
Date: Tue, 04 Dec 2001 23:52:20 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Derrik Pates <dpates@dsdk12.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
References: <Pine.LNX.4.40.0112012136190.20456-100000@andromeda.dsdk12.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derrik Pates wrote:
>
> I've been trying the latest rsync snaps from your kernel tree
> (particularly to fix the time-warp bug that pops up in 2.4.16-ben0), but
> I've discovered that these latest trees cause the iBook FireWire that I'm
> using to hang up when I try to bring the unit out of suspend mode. The
> "sleep" indicator stops pulsating, and the drive spins up - I can hear it
> - but it never wakes up. The backlight never comes on, and typing at the
> keyboard (into a root shell - I was at a console logged in as root when I
> suspended) has no effect, apparently indicating it's really gone.
> Rebooting into 2.4.16-ben0 and suspending still works as normal, so I know
> it's not hardware.

i'm seeing the same, but on 2.4.16-ben0 on a pismo powerbook.
it does not happen every time, but often enough to be almost
unusable.

i *think* it gets triggered when i hit a button immediately after
the screen has blanked. when i wait a couple of seconds until the
suspend led has started blinking, i get the machine back most of the
time.

when it dies, the hd comes up, but the screen remains black. i tried
blind-typing "reboot" in a root shell, but nothing happened. i could
not ssh into the box from outside. there are no ping echos.



--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
