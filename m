Message-ID: <F9102D41F595D311ACA7009027DE2C840527B245@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: "'ARIBAUD Albert'" <A.ARIBAUD@giat-industries.fr>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: (X-Window) Yellowdog RPMs within ELDK?
Date: Mon, 12 May 2003 11:34:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just downloaded the tar.gz files from xfree86.org, then
m4, bison, flex, and perl from their respective sites and compiled
them natively using the ELDK 2.1.0. It was quite easy for my ppc_7xx
platform and I had xboard up and running on my embedded 800MHz
PowerPC-750FX in no time.




-----Original Message-----
From: ARIBAUD Albert [mailto:A.ARIBAUD@giat-industries.fr]
Sent: Monday, May 12, 2003 10:40 AM
To: Linuxppc-Embedded (E-mail)
Subject: (X-Window) Yellowdog RPMs within ELDK?



Hi all,

I need to install X libraries and apps on
our custom 855T-based board running Linux.
Since ELDK derives from Yellowdog, I thought
I'd use RPMs from Yellowdog.

Trouble is, if I 'ppc-rpm' an YDL package,
I get an architecture mismatch (which is
not surprising, all ELDK packages being
'ppc_8xx' while YDL packages are 'ppc').

I've tried a sneaky --ignorearch, which
led ppc-rpm to seemingly accept the
previously offending package. But then,
if I 'ppc-rpm -qa', the package isn't
listed.

Anybody help! :)

Thanks in advance,

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
