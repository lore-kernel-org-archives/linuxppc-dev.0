Message-ID: <3BE2DAC2.FEB5AAC2@mvista.com>
Date: Fri, 02 Nov 2001 10:41:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: Dag Nygren <dag@newtech.fi>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: EPIC Vs OpenPIC Vs MontaVista
References: <20011102152550.14933.qmail@mailweb16.rediffmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath, Dag, Andrew,

What I think you guys are discovering is an artifact of the inadequate
interface to openpic_init()--its wider than just a 8259/107 problem.  This has
been discussed before and some ideas kick around.

Since you guys seem to have the time & motivation, why don't you go back &
check out the mail archives for that/those discussion(s).  If you like what
was talked about there, go with it or come up with a better solution and post
it here for everyone to comment on.  It would be really nice to have a more
flexible interface to openpic_init(), et. al.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
