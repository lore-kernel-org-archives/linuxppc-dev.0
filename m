Date: Wed, 27 Oct 1999 12:48:24 -0500 (CDT)
From: Jeff Zahourek <jeffzahourek@cjnetworks.com>
Reply-To: jeffzahourek@cjnetworks.com
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Netscape and missing libnullplugin.so
In-Reply-To: <199910271530.KAA32070@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.9910271239560.27852-100000@thor.valhalla.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I believe the libnullplugin.so is needed. I built the Plugger 3.0 plugin
on linuxppc but it would not work. I have the same plugin working on
linux-i386. The i386 Netscape v4.7 has libnullplugin.so and removing it
causes Plugger 3.0 to fail exactly as it does on the Netscape v4.7 on
linuxppc. Put it back and the plugin works normally.

Jeff
-- 
{]>===-                       {]>===-                         {]>===- 
Jeff Zahourek                            Because without beer, things
jeffzahourek@cjnetworks.com              do not seem to go as well.
http://www.cjnetworks.com/~jeffzahourek/                 -- Anonymous


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
