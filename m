Date: Thu, 22 Jul 1999 14:28:41 +0200
From: Lucas Vergnettes <lucas@promac.org>
To: LinuxPPC Developpers <linuxppc-dev@lists.linuxppc.org>
Subject: Bug Report : Kernel Panic w/ PPP & Netscape
Message-ID: <19990722142841.A811@promac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi everyone.

Iwolud like to submit a bug report. This problem happens on my box something
like 2 times a day, and is ~quite~ annoying ;)

I hope this is the good place for this kind of messages.

The situation :
A powermac 7300/166, YellowDog 1.0, an ATI video card (the one from the 9500s
ATY,MACH64) and an Olitec 56k modem.

When I startup ny internet connexion (ala redhat : ifup ppp0), everything is
ok, but when i start browsing with netscape, the problems begin... This is a
typical log :

Jul 22 14:01:14 wip ifup-ppp: pppd started for ppp0 on /dev/ttyS1 at 115200
Jul 22 14:01:15 wip kernel: registered device ppp0
Jul 22 14:01:15 wip pppd[614]: pppd 2.3.5 started by root, uid 0
Jul 22 14:01:16 wip chat[617]: send (AT&F1M0^M)
Jul 22 14:01:16 wip chat[617]: expect (OK)
Jul 22 14:01:16 wip chat[617]: ^M
Jul 22 14:01:16 wip chat[617]: OK
Jul 22 14:01:16 wip chat[617]:  -- got it
Jul 22 14:01:16 wip chat[617]: send (ATDT0836019301^M)
Jul 22 14:01:16 wip chat[617]: expect (CONNECT)
Jul 22 14:01:16 wip chat[617]: ^M
Jul 22 14:01:47 wip chat[617]: ATDT0836019301^M^M
Jul 22 14:01:47 wip chat[617]: CONNECT
Jul 22 14:01:47 wip chat[617]:  -- got it
Jul 22 14:01:47 wip chat[617]: send (^M)
Jul 22 14:01:47 wip chat[617]: send (AT&F1^M)
Jul 22 14:01:47 wip pppd[614]: Serial connection established.
Jul 22 14:01:48 wip pppd[614]: Using interface ppp0
Jul 22 14:01:48 wip pppd[614]: Connect: ppp0 <--> /dev/ttyS1
Jul 22 14:01:48 wip pppd[614]: Remote message:
Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-21
Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-26
Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-24
Jul 22 14:01:49 wip pppd[614]: local  IP address 193.250.81.28
Jul 22 14:01:49 wip pppd[614]: remote IP address 193.251.116.157
Jul 22 14:02:00 wip kernel: FB. overflow: 1
Jul 22 14:02:00 wip kernel: FB. overflow: 2
Jul 22 14:02:00 wip kernel: FB. overflow: 3

And the FB.overflow message count up to 1000 sometimes, but in general, I get
a superb Kernel panic before, which forces me to reboot ans fsck my disks...

The funny thing is that when the FB messages flood the console, i can stop
them by shutting down my modem. WHen I power it again, the messages restart to
flow! 

In fact, this hasn't happened only w/ Netscape, but it is a favorising factor
;)
I have even got this kind of panic while being on the console (No X!)...
I suppose it might be an atyfb problem.
My card makes raindow lines on the screen when there are too much colors.

This problem has occured with :
The 2.2.1 precompiled from paul, a home compiled one from me.
The Linus' 2.2.10 home made w/ turbomouse & mol patches, but they aren't in
cause.

Hope this will help to track something.

Staying at your disposition for testings and further info..

Lucas
 
-- 
Lucas Vergnettes  -- Osteopathy Student --  mailto:lucas@promac.org
LinuxPPC, Ostéopathie et astuces telnet sur http://lucas.promac.org
EMACS : Escape-Meta-Alt-Control-Shift
 





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
