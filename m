Subject: Error encountered when make of gcc-3.3.2
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF4C3019EA.ACB29788-ON65256E31.0024D5FB@lntinfotech.com>
From: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Date: Thu, 5 Feb 2004 12:16:17 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,

i am currently building my toolchain for powerpc i encountered the
following error during "MAKE"
could anyone help me out in this regard

Thanks in advance

 ERROR
------------
if [ -f stmp-dirs ]; then true; else touch stmp-dirs; fi
/root/Thamarai/gcc-3.3.2/gcc/xgcc -B/root/Thamarai/gcc-3.3.2/gcc/
-B/usr/local/powerpc-linux/bin/ -B
/usr/local/powerpc-linux/lib/ -isystem /usr/local/powerpc-linux/include -O2
-DIN_GCC -DCROSS_COMPIL
E   -W -Wall -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes
-isystem ./include  -fPIC -g
-DIN_LIBGCC2 -D__GCC_FLOAT_NOT_NEEDED -Dinhibit_libc -I. -I. -I. -I./.
-I./config -I./../include  -f
PIC -mstrict-align -DL_muldi3 -c ./libgcc2.c -o libgcc/./_muldi3.o
In file included from tconfig.h:22,
                 from libgcc2.c:36:
config/rs6000/linux.h:89:20: signal.h: No such file or directory
In file included from tconfig.h:22,
                 from libgcc2.c:36:
config/rs6000/linux.h:98: error: parse error before "stack_t"
config/rs6000/linux.h:98: warning: no semicolon at end of struct or union
config/rs6000/linux.h:100: error: parse error before "uc_sigmask"
config/rs6000/linux.h:100: warning: type defaults to `int' in declaration
of `uc_sigmask'
config/rs6000/linux.h:100: warning: data definition has no type or storage
class
config/rs6000/linux.h:99: error: storage size of `uc_mcontext' isn't known
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: Leaving directory `/root/Thamarai/gcc-3.3.2/gcc'
make[1]: *** [stmp-multilib] Error 2
make[1]: Leaving directory `/root/Thamarai/gcc-3.3.2/gcc'
make: *** [all-gcc] Error 2

 With Regards,
 Thamarai Selvan.G
 (:  91-22-27612571, 27621100 X 4115
________________________________________________________

 "Life - endless river of dreams, smiles in the portray of an artist"
- Thams


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
