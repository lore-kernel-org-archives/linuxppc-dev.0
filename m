Message-ID: <000f01c12d79$63013200$0401a8c0@trex>
From: "Jeff Rugen" <jprugen@earthlink.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: XFree86 4.1 with clgenfb framebuffer
Date: Sat, 25 Aug 2001 08:19:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've installed XFree86 4.1 for the powerpc from xfree86.org, and am trying
to get X working again.  I am using a Motorola Powerstack (prep) with the
clgenfb framebuffer, and linux 2.2.20pre6.  The console works fine on the
framebuffer (I only have a framebuffer console in the kernel right now).  I
have what almost seems to be a working XF86Config file, but when I start X
(using the startx script), it doesn't work completely.  I get a blank
screen.  However, when I look at the running processes, xinit. xclock, and
twm are running with my permissions, and X and 3 xterms are running with
root permissions (shouldn't the xterms be with my permissions too?).  When I
quit X, the screen stays blank (though I do see a flicker), and I have to
reboot to get a display back.  One thing that makes me curious is that the
shadow framebuffer is being loaded, and I don't specify it in the XF86Config
file.  (And yes, it is using the config file I think it is using -- the
output from starting it verifies that).  Another is that it indicates that
DPMS is enabled (could I be going into DPMS mode and not coming out of it?)

Does anyone have any suggestions, or alternate XF86Config files I could try?
I don't remember if I pulled the 2.4 clgen framebuffer code back into my 2.2
tree, but my tree is based on rsync from vger.samba.org/vger-2.2, so I could
pretty easily generate a diff on it (though if you'd like this, telling me
the command to generate the diff would save me the time from looking it up
:)  ).

Thanks for any help.

Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
