From: Ruedi.Hofer@ascom.ch
Date: Mon, 02 Oct 2000 13:43:27 +0100 (CED)
Subject: Re: Re: Re: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
To: vanbaren_gerald@si.com
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1S00J8YWKI5F@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_9DY7epDT52J/H/5gfAaH1A)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_9DY7epDT52J/H/5gfAaH1A)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi gerald

Do you mind sending these files directly in a sort of tgz form to me?

# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   3708 -rw-r--r-- arch/ppc/mbxboot/Makefile
#    156 -rw-r--r-- arch/ppc/mbxboot/gzimage.c
#    156 -rw-r--r-- arch/ppc/mbxboot/rdimage.c
#   3415 -rw-r--r-- arch/ppc/mbxboot/vmlinux.lds
#

I really struggle decoding them. I somehow loose tabs, sh reports errors...


Thank you

\Ruedi






vanbaren_gerald@si.com on 28.09.2000 17:31:07
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:
Thema: Re: Re: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel

Ruedi:

Any luck?  Jon Diekema (a coworker) solved the problem for us with a
Makefile patch.  For details, see the summary of the May messages,
which includes Jon's proposed patch:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/linuxppc-embedded.200005

For convenience, I've included it below.  If you cannot get my previous
suggestions to make the load happen, perhaps you can try the Makefile
patch and then do a header  dump to see how it is different.

gvb


  From owner-linuxppc-embedded@lists.linuxppc.org  Tue May  9 12:52:58 2000
Message-Id: <m12pEA0-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Getting the image section of the ELF file to load w/
VxWorks boot ROM
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 9 May 2000 13:51:08 -0400 (EDT)
In-Reply-To: <391834D3.9E57B710@Zentropix.com> from "Daniel G.
Clemmensen" at May 09, 2000 11:54:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The approach that I settled upon was identified in my initial post,
however I didn't actually do all the steps.  I have attached the the
files that are needed to make it work.

Note: The Linux_2_3 BitKeeper repository at FMS Labs contains
       these changes.

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2000-05-09 13:39 EDT by <diekema@bucks>.
# Source directory was `/home/bucks/users/diekema'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   3708 -rw-r--r-- arch/ppc/mbxboot/Makefile
#    156 -rw-r--r-- arch/ppc/mbxboot/gzimage.c
#    156 -rw-r--r-- arch/ppc/mbxboot/rdimage.c
#   3415 -rw-r--r-- arch/ppc/mbxboot/vmlinux.lds
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
   if test "$gettext_dir" = FAILED && test -f $dir/gettext \
      && ($dir/gettext --version >/dev/null 2>&1)
   then
     set `$dir/gettext --version 2>&1`
     if test "$3" = GNU
....
....
X  _rdstart = . ;
X  .rdimage : { *(.rdimage) }
X  _rdend   = . ;
X
}
SHAR_EOF
   $shar_touch -am 05060231100 'arch/ppc/mbxboot/vmlinux.lds' &&
   chmod 0644 'arch/ppc/mbxboot/vmlinux.lds' ||
   $echo 'restore of' 'arch/ppc/mbxboot/vmlinux.lds' 'failed'
   if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
   && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
     md5sum -c << SHAR_EOF >/dev/null 2>&1 \
     || $echo 'arch/ppc/mbxboot/vmlinux.lds:' 'MD5 check failed'
5dfe86d647b2e619ecd80dc9b32c7c65  arch/ppc/mbxboot/vmlinux.lds
SHAR_EOF
   else
     shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c <
'arch/ppc/mbxboot/vmlinux.lds'`"
     test 3415 -eq "$shar_count" ||
     $echo 'arch/ppc/mbxboot/vmlinux.lds:' 'original size' '3415,'
'current size' "$shar_count!"
   fi
fi
rm -fr _sh04766
exit 0


--
------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991





--Boundary_(ID_9DY7epDT52J/H/5gfAaH1A)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
