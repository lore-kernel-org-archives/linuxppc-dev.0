Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross compiling : problem linking
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1065099415.10206.5.camel@toni>
References: <1065099415.10206.5.camel@toni>
Content-Type: text/plain
Message-Id: <1065101196.10206.7.camel@toni>
Mime-Version: 1.0
Date: Thu, 02 Oct 2003 15:26:36 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Reduced the error to:

toni rt_mod # make
ppc_4xx-gcc -g -O -Werror   -c -o rt_mod.o rt_mod.c
ppc_4xx-gcc -nostartfiles -fno-exceptions -fno-builtin  -o rt_mod
rt_mod.o
/opt/eldk/usr/ppc-linux/bin/ld: warning: cannot find entry symbol
_start; defaulting to 10000184
rt_mod.o: In function `block_wave':
/ppc/rt_mod/rt_mod.c:14: undefined reference to `outb'
/ppc/rt_mod/rt_mod.c:14: relocation truncated to fit: R_PPC_REL24 outb
rt_mod.o: In function `main':
/ppc/rt_mod/rt_mod.c:21: undefined reference to `iopl'
/ppc/rt_mod/rt_mod.c:21: relocation truncated to fit: R_PPC_REL24 iopl
collect2: ld returned 1 exit status
make: *** [rt_mod] Fout 1

Somebody?
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
