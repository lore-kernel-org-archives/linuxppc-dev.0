Date: Sat, 17 Jun 2000 02:20:46 +0200
From: Claus Enneper <cl.en@gmx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: quik-1.3.1and 2.2.16_pmac-stable ?
Message-ID: <20000617022046.C508@olis.north.de>
Reply-To: cl.en@gmx.net
References: <20000617010541.B508@olis.north.de> <20000616233416.1720@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000616233416.1720@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Sat, Jun 17, 2000 at 01:34:16AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 >:
 >: Ah, yes, it's a different issue. You should probably use a more recent
 >: quik (2.0+) to work with recent kernels. Old quik doesn't like the new
 >: kernel entry point (without the pseudo-xcoff hack).

is there any binary available?
quik-2.0-0d.src.rpm from Yellow Dog Linux <bugs@terraplex.com> complains:

make[1]: Entering directory `/usr/src/redhat/BUILD/quik-2.0/util'
gcc -O2 -o elfextract elfextract.c
In file included from /usr/include/linux/elf.h:5,
                 from elfextract.c:7:
/usr/include/asm/elf.h:43: parse error before `elf_vrreg_t'
/usr/include/asm/elf.h:43: warning: data definition has no type or storage class/usr/include/asm/elf.h:44: parse error before `elf_vrregset_t'
/usr/include/asm/elf.h:44: warning: data definition has no type or storage classmake[1]: *** [elfextract] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/quik-2.0/util'
make: *** [all] Error 1
Bad exit status from /var/tmp/rpm-tmp.35142 (%build)

--
Yours, ce

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
