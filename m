Date: Tue, 24 Jul 2001 15:14:00 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: make dep fails at acpi
Message-ID: <20010724151400.A25666@thislove>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is from the kernel source recently rsync'd from mvista. 'make dep'
fails like this about 10 seconds in:


make -C acpi fastdep
make[4]: Entering directory `/home/gwyn/Projects/kernel/drivers/acpi'
gcc -D__KERNEL__ -I/home/gwyn/Projects/kernel/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-D_LINUX -I/include -E -D__GENKSYMS__ acpi_ksyms.c
| /sbin/genksyms  -k 2.4.7 >
/home/gwyn/Projects/kernel/include/linux/modules/acpi_ksyms.ver.tmp
acpi_ksyms.c:27: acpi.h: No such file or directory
acpi_ksyms.c:28: acdebug.h: No such file or directory
mv /home/gwyn/Projects/kernel/include/linux/modules/acpi_ksyms.ver.tmp
/home/gwyn/Projects/kernel/include/linux/modules/acpi_ksyms.ver
/home/gwyn/Projects/kernel/scripts/mkdep -D__KERNEL__
-I/home/gwyn/Projects/kernel/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -D_LINUX -I/include --
acpi_ksyms.c driver.c driver.h os.c > .depend
realpath(/include) failed, No such file or directory
make[4]: *** [fastdep] Error 1
make[4]: Leaving directory `/home/gwyn/Projects/kernel/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/home/gwyn/Projects/kernel/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/home/gwyn/Projects/kernel/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/home/gwyn/Projects/kernel'
make: *** [dep-files] Error 2

--
Gwyn Judd (b.judd@xtra.co.nz)
Iam
not
very
happy
acting
pleased
whenever
prominent
scientists
overmagnify
intellectual
enlightenment

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
