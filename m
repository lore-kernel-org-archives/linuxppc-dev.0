Date: Thu, 17 Oct 2002 14:16:03 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: "D'Abbraccio Joe-ljd015" <Joe.D'abbraccio@motorola.com>
Cc: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	"'Hollis Blanchard'" <hollis@austin.ibm.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: cross-compiler and stdarg.h
In-Reply-To: <6D4DC8B4AD16D6118E8200D0B76FE2620231973C@ONT06EXM01>
Message-ID: <Pine.LNX.4.40.0210171411090.1181-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 11 Oct 2002, D'Abbraccio Joe-ljd015 wrote:

> Doesn't this patch simply negate the -nostdinc switch (i.e. the resulting
> switch is something like "-I /usr/opt/eldk-1.0.1/usr/lib/gcc-lib/ppc-linux/2.95.3/include"
> which is part of stdinc) ?

It only negates _parts_ of -nostdinc. You are right in pointing out the
potential ugliness of this solution. The culprit lies IMHO pretty deep in
strong interconnection of components which is inherent to UNIX. (Note that
this is not meant to be flame bait, please ignore this mail if it offends
you. :-)

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
