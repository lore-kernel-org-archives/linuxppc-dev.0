From: "Timothy Pollock" <timothy.pollock@motorola.com>
To: "Mark Hatle" <fray@mvista.com>,
	"Grant Erickson" <erick205@umn.edu>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Patch for Soft-Float Problems w/ Glibc & Gcc?
Date: Tue, 13 Feb 2001 18:09:47 -0600
Message-ID: <NEBBIFNAFPLEINPHHMHHGEBLCAAA.timothy.pollock@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
In-reply-to: <3A8974B8.D197FEC9@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


powerpc-eabi-objdump -S ces | egrep
'mtfsf|lfd|lfs|stfd|stflwx|stfs|:[ \t]*(fc|fd|fe|ff|ec|ed|ee|ef) '

Here's a useful little one-liner that lets you find out if there are any
floating point instructions in an object file.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
