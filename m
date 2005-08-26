Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 630AC67FA7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 10:48:57 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j7Q8h1D0035726
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Aug 2005 08:43:02 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 26 Aug 2005 08:48:44 +0800
Message-Id: <1125017324.7073.4.camel@banana>
Mime-Version: 1.0
Subject: rebuild net-snmp 5.0.6 from eldk 3.1.1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

    Anybody know how to setting fedora linux 3 environment to cross
compile netsnmp 5.0.6
contain in the eldk 3.1.1.

   I'v try to modify net-snmp.spec for using pcc_8xx-gcc, but still got
probems.

[root@banana SPECS]# ppc_8xx-rpmbuild -ba --with ee net-snmp.spec
Executing(%prep): /bin/sh -e /opt/eldk/var/tmp/rpm-tmp.4936
+ umask 022
+ cd /opt/eldk/usr/src/denx/BUILD
+ cd /opt/eldk/usr/src/denx/BUILD
+ rm -rf net-snmp-5.0.6
+ /bin/gzip -dc /opt/eldk/usr/src/denx/SOURCES/net-snmp-5.0.6.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd net-snmp-5.0.6
+ echo 'Patch #9 (net-snmp-5.0.1-initializer.patch):'
Patch #9 (net-snmp-5.0.1-initializer.patch):
+ patch -p1 -b --suffix .initializer -s
+ echo 'Patch #10 (net-snmp-5.0.1-nolibelf.patch):'
Patch #10 (net-snmp-5.0.1-nolibelf.patch):
+ patch -p1 -b --suffix .nolibelf -s
+ echo 'Patch #11 (net-snmp-5.0.6-syslog.patch):'
Patch #11 (net-snmp-5.0.6-syslog.patch):
+ patch -p1 -b --suffix .syslog -s
+ echo 'Patch #12 (net-snmp-5.0.6-nodb.patch):'
Patch #12 (net-snmp-5.0.6-nodb.patch):
+ patch -p1 -b --suffix .nodb -s
+ echo 'Patch #13 (net-snmp-5.0.6-compat.patch):'
Patch #13 (net-snmp-5.0.6-compat.patch):
+ patch -p1 -b --suffix .compat -s
+ echo 'Patch #14 (net-snmp-5.0.6-smux.patch):'
Patch #14 (net-snmp-5.0.6-smux.patch):
+ patch -p1 -b --suffix .smux -s
+ echo 'Patch #15 (net-snmp-5.0.6-libtool.patch):'
Patch #15 (net-snmp-5.0.6-libtool.patch):
+ patch -p1 -b --suffix .libtool -s
+ echo 'Patch #16 (net-snmp-5.0.6-smux_pktsz_err_rpt.patch):'
Patch #16 (net-snmp-5.0.6-smux_pktsz_err_rpt.patch):
+ patch -p1 -b --suffix .smux_pktsz_err_rpt -s
+ perl -pi -e 's|'\''\$install_libdir'\''|'\''/usr/lib'\''|' ltmain.sh
+ exit 0
Executing(%build): /bin/sh -e /opt/eldk/var/tmp/rpm-tmp.96354
+ umask 022
+ cd /opt/eldk/usr/src/denx/BUILD
+ cd net-snmp-5.0.6
+ endianess=little
+ endianess=big
+ CFLAGS='-O2 -g -fsigned-char'
+ export CFLAGS
+ CXXFLAGS='-O2 -g -fsigned-char'
+ export CXXFLAGS
+ FFLAGS='-O2 -g -fsigned-char'
+ export FFLAGS
+ ./configure --host=i386-pc-linux-gnu --build=i386-pc-linux-gnu --
target=ppc-denx-linux --program-prefix= --prefix=/usr --exec-prefix=/usr
--bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --
datadir=/usr/share --includedir=/usr/include/net-snmp --libdir=/usr/lib
--libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/usr/com
--mandir=/usr/share/man --infodir=/usr/share/info --host=ee --enable-
static --enable-shared --with-cc=/opt/eldk/usr/bin/ppc_8xx-gcc --with-
ar=/opt/eldk/usr/bin/ppc_8xx-ar '--with-cflags=-O2 -g -fsigned-char' --
with-sys-location=Unknown --with-logfile=/var/log/snmpd.log --with-
persistent-directory=/var/net-snmp '--with-mib-modules=host agentx smux'
--with-libwrap=/usr/lib --sysconfdir=/etc --enable-ipv6 --enable-ucd-
snmp-compatibility --with-endianness=big --disable-debugging --enable-
mini-agent --with-default-snmp-version=2 --with-sys-
contact=root@localhost
creating cache ./config.cache
using default enterprise.net-snmp
using default enterprise sysOID NET-SNMP-MIB::netSnmpAgentOIDs...
using default notifications NET-SNMP-MIB::netSnmpNotifications
checking if I need to feed myself to ksh... no
checking for gcc... /opt/eldk/usr/bin/ppc_8xx-gcc
checking whether the C compiler (/opt/eldk/usr/bin/ppc_8xx-gcc -O2 -g -
fsigned-char ) works... yes
checking whether the C compiler (/opt/eldk/usr/bin/ppc_8xx-gcc -O2 -g -
fsigned-char ) is a cross-compiler... yes
checking whether we are using GNU C... yes
checking whether /opt/eldk/usr/bin/ppc_8xx-gcc accepts -g... yes
checking how to run the C preprocessor... /opt/eldk/usr/bin/ppc_8xx-gcc
-E
checking for AIX... no
checking for Cygwin environment... no
checking for mingw32 environment... no
checking for executable suffix... no
checking host system type... Invalid configuration `ee': machine `ee'
not recognized

checking build system type... i386-pc-linux-gnu
checking for ld used by GCC... /opt/eldk/usr/ppc-linux/bin/ld
checking if the linker (/opt/eldk/usr/ppc-linux/bin/ld) is GNU ld... yes
checking for /opt/eldk/usr/ppc-linux/bin/ld option to reload object
files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking whether ln -s works... yes
checking how to recognise dependant libraries... unknown
checking for object suffix... o
./configure: line 2477: test: !=: unary operator expected
checking command to parse /usr/bin/nm -B output... ok
checking for dlfcn.h... yes
checking for ranlib... ranlib
checking for strip... strip
checking for objdir... .libs
checking for /opt/eldk/usr/bin/ppc_8xx-gcc option to produce PIC... -
fPIC
checking if /opt/eldk/usr/bin/ppc_8xx-gcc PIC flag -fPIC works... yes
checking if /opt/eldk/usr/bin/ppc_8xx-gcc static flag -static works...
yes
checking if /opt/eldk/usr/bin/ppc_8xx-gcc supports -c -o file.o... yes
checking if /opt/eldk/usr/bin/ppc_8xx-gcc supports -c -o file.lo...
checking if /opt/eldk/usr/bin/ppc_8xx-gcc supports -fno-rtti -fno-
exceptions... yes
checking whether the linker (/opt/eldk/usr/ppc-linux/bin/ld) supports
shared libraries... yes
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking dynamic linker characteristics... no
checking if libtool supports shared libraries... no
checking for dlopen in -ldl... yes
checking whether a program can dlopen itself... cross
checking whether -lc should be explicitly linked in... no
creating libtool
checking for a BSD compatible install... /usr/bin/install -c
checking whether ln -s works... (cached) yes
checking whether make sets ${MAKE}... yes
checking for ps... /bin/ps
checking for perl... /usr/bin/perl
checking for whoami... whoami
checking for sed... sed
checking for autoconf... no
checking for autoheader... no
checking for uname... /bin/uname
checking for working const... yes
checking for inline... inline
checking for net-snmp version number... 5.0.6
checking for developer gcc flags... none
checking host system type... config.sub: missing argument
Try `config.sub --help' for more information.

checking target system type... powerpc-denx-linux-gnu
checking build system type... i386-pc-linux-gnu
checking for system include file... net-snmp/system/linux.h
checking for machine-type include file... net-snmp/machine/generic.h
checking for /opt/eldk/usr/bin/ppc_8xx-gcc... no
checking for additional cpp flags... -x c
checking ipv6 stack type... linux-glibc, yes, using libc
checking whether we have to build PIC code... no
checking for and configuring transport modules to use...  Callback Unix
TCP UDP TCPIPv6 UDPIPv6.
checking for security modules to use...  usm
checking for and configuring mib modules to use...  snmpv3mibs
mibII/snmp_mib mibII/system_mib mibII/sysORTable examples/ucdDemoPublic
mibII/vacm_vars host agentx smux mibII/ipv6.
checking for and configuring mib modules pieces to use...  snmpv3mibs
mibII/snmp_mib mibII/system_mib mibII/sysORTable examples/ucdDemoPublic
mibII/vacm_vars host agentx smux mibII/ipv6 snmpv3/snmpEngine
snmpv3/snmpMPDStats snmpv3/usmStats snmpv3/usmUser util_funcs
mibII/vacm_context host/hr_system host/hr_storage host/hr_device
host/hr_other host/hr_proc host/hr_network host/hr_print host/hr_disk
host/hr_partition host/hr_filesys host/hr_swrun host/hr_swinst
agentx/master agentx/subagent smux/smux mibII/interfaces mibII/at
mibII/var_route mibII/route_write ucd-snmp/loadave agentx/protocol
agentx/client agentx/master_admin agentx/agentx_config mibII/ip
mibII/kernel_linux mibII/ipAddr.
checking if directories need to be created... .
checking default mib files to read... SNMPv2-MIB:RFC1213-MIB:SNMP-VIEW-
BASED-ACM-MIB:SNMP-COMMUNITY-MIB:HOST-RESOURCES-MIB:HOST-RESOURCES-
TYPES:IPV6-ICMP-MIB:IPV6-MIB:IPV6-TCP-MIB:IPV6-UDP-MIB:SNMP-FRAMEWORK-
MIB:SNMP-MPD-MIB:SNMP-USER-BASED-SM-MIB
checking for location of system kernel... unknown
checking for mount table location... /etc/mtab
checking for location of swap device... none
checking for asin in -lm... yes
checking for gethostbyname... yes
checking for getservbyname... yes
checking for kstat_lookup in -lkstat... no
checking for nlist in -lmld... no
checking for EVP_md5 in -lcrypto... yes
checking for AES_cfb128_encrypt... yes
checking for tcpd.h... yes
checking for TCP wrappers library -lwrap... no
checking for yp_get_default_domain... no
checking for yp_get_default_domain in -lnsl... yes
checking for TCP wrappers library -lwrap linked with -lnsl... yes
checking for zlib.h... yes
checking for gzread in -lz... yes
checking for bzread in -lbz2... no
checking for BZ2_bzread in -lbz2... yes
checking for poptParseArgvString in -lpopt... yes
checking for Fopen in -lrpmio... yes
checking for rpmGetFilesystemList in -lrpm... no
checking for rpmdbOpen in -lrpmdb... no
checking for kvm_read in -lkvm... no
checking for dlopen in -ldl... (cached) yes
checking for kvm_openfiles... no
checking for nlist... no
checking for knlist... no
checking for kvm_getprocs... no
checking whether we need -ldevstat for diskio MIB... no
checking for ANSI C header files... yes
checking for dirent.h that defines DIR... yes
checking for opendir in -ldir... no
checking for sys/wait.h that is POSIX.1 compatible... yes
checking for stdarg.h... yes
checking for string.h... yes
checking for fcntl.h... yes
checking for limits.h... yes
checking for sys/file.h... yes
checking for sys/ioctl.h... yes
checking for syslog.h... yes
checking for unistd.h... yes
checking for netinet/tcpip.h... no
checking for netinet/in.h... yes
checking for netinet/ip.h... yes
checking for netinet/ip_icmp.h... yes
checking for net/if.h... yes
checking for netdb.h... yes
checking for sys/dmap.h... no
checking for machine/pte.h... no
checking for xti.h... no
checking for sys/sockio.h... no
checking for sys/socket.h... yes
checking for sys/un.h... yes
checking for fstab.h... yes
checking for sys/fs.h... no
checking for mtab.h... no
checking for ufs/fs.h... no
checking for ufs/ffs/fs.h... no
checking for sys/fixpoint.h... no
checking for machine/param.h... no
checking for sys/vm.h... no
checking for vm/vm.h... no
checking for sys/vmmeter.h... no
checking for sys/vmparam.h... no
checking for sys/vmmac.h... no
checking for sys/vmsystm.h... no
checking for sys/mbuf.h... no
checking for sys/time.h... yes
checking for sys/swap.h... yes
checking for inet/mib2.h... no
checking for sys/statvfs.h... yes
checking for sys/vfs.h... yes
checking for sys/mnttab.h... no
checking for sys/user.h... yes
checking for sys/proc.h... no
checking for sys/select.h... yes
checking for mntent.h... yes
checking for sys/mntent.h... no
checking for kstat.h... no
checking for utsname.h... no
checking for sys/utsname.h... yes
checking for sys/cdefs.h... yes
checking for getopt.h... yes
checking for locale.h... yes
checking for pthread.h... yes
checking for sys/loadavg.h... no
checking for regex.h... yes
checking for linux/tasks.h... no
checking for pwd.h... yes
checking for grp.h... yes
checking for utmpx.h... yes
checking for malloc.h... yes
checking for sys/param.h... yes
checking for net/if_dl.h... no
checking for sys/sysctl.h... yes
checking for stdlib.h... yes
checking for net/if_mib.h... no
checking for net/if_types.h... no
checking for net/if_var.h... no
checking for sys/queue.h... yes
checking for osreldate.h... no
checking for machine/types.h... no
checking for sys/socketvar.h... yes
checking for sys/conf.h... no
checking for netinet/in_systm.h... yes
checking for netinet/tcp.h... yes
checking for netinet/udp.h... yes
checking for netinet/in_var.h... no
checking for netinet/if_ether.h... yes
checking for netinet/ip_var.h... no
checking for netinet/tcp_timer.h... no
checking for netinet/tcp_var.h... no
checking for netinet/tcp_fsm.h... no
checking for netinet/udp_var.h... no
checking for netinet/icmp_var.h... no
checking for sys/protosw.h... no
checking for nlist.h... no
checking for ioctls.h... no
checking for asm/page.h... yes
checking for netipx/ipx.h... yes
checking for arpa/inet.h... yes
checking for kvm.h... no
checking for sys/pool.h... no
checking for uvm/uvm_param.h... no
checking for uvm/uvm_extern.h... no
checking for vm/vm_param.h... no
checking for vm/vm_extern.h... no
checking for sys/mount.h... yes
checking for vm/swap_pager.h... no
checking for ufs/ufs/dinode.h... no
checking for sys/stat.h... yes
checking for sys/vnode.h... no
checking for ufs/ufs/quota.h... no
checking for ufs/ufs/inode.h... no
checking for sys/hashing.h... no
checking for sys/tcpipstats.h... no
checking for sys/sysmp.h... no
checking for err.h... yes
checking for sys/filio.h... no
checking for sgtty.h... yes
checking for sys/statfs.h... yes
checking for net/route.h... yes
checking for sys/dkio.h... no
checking for sys/diskio.h... no
checking for sys/pstat.h... no
checking for linux/hdreg.h... yes
checking for pkglocs.h... no
checking for pkginfo.h... no
checking for winsock.h... no
checking for io.h... no
checking for sys/stream.h... no
checking for netinet/ip6.h... yes
checking for netinet6/in6_var.h... no
checking for netinet6/in6_pcb.h... no
checking for netinet6/ip6_var.h... no
checking for netinet6/tcp6.h... no
checking for netinet6/tcp6_fsm.h... no
checking for netinet6/nd6.h... no
checking for netinet6/tcp6_timer.h... no
checking for netinet6/tcp6_var.h... no
checking for dlfcn.h... (cached) yes
checking for search.h... yes
checking for rpmio.h... no
checking for rpm/rpmio.h... yes
checking for netinet/in_pcb.h... no
checking for sys/disklabel.h... no
checking for openssl/hmac.h... yes
checking for openssl/evp.h... yes
checking for openssl/aes.h... yes
checking for openssl/des.h... yes
checking for lpstat... /usr/bin/lpstat
checking for cgetnext... no
checking for authentication support... OpenSSL Support
checking for off_t... yes
checking for pid_t... yes
checking whether time.h and sys/time.h may both be included... yes
checking for socklen_t... yes
checking for in_addr_t... yes
checking for correct flags to ps...
checking for working alloca.h... yes
checking for alloca... yes
checking whether /opt/eldk/usr/bin/ppc_8xx-gcc needs -traditional... no
checking for 8-bit clean memcmp... no
checking return type of signal handlers... void
checking for getmntent in -lsun... no
checking for getmntent in -lseq... no
checking for getmntent in -lgen... no
checking for getmntent... yes
checking for setmntent... yes
checking for gethostname... yes
checking for uname... yes
checking for gettimeofday... yes
checking for select... yes
checking for socket... yes
checking for strtol... yes
checking for strtoul... yes
checking for strchr... yes
checking for strdup... yes
checking for memcpy... yes
checking for memmove... yes
checking for index... yes
checking for bcopy... yes
checking for strcasestr... yes
checking for regcomp... yes
checking for signal... yes
checking for setsid... yes
checking for sigset... yes
checking for sigblock... yes
checking for sighold... yes
checking for strerror... yes
checking for setenv... yes
checking for vsnprintf... yes
checking for snprintf... yes
checking for sigaction... yes
checking for snprintf... (cached) yes
checking for strtoul... (cached) yes
checking for random... yes
checking for lrand48... yes
checking for rand... yes
checking for execv... yes
checking for system... yes
checking for fork... yes
checking for getpid... yes
checking for strncasecmp... yes
checking for sigalrm... no
checking for rpmGetPath... no
checking for getloadavg... yes
checking for getaddrinfo... yes
checking for getipnodebyname... no
checking for statvfs... yes
checking for statfs... yes
checking for getdtablesize... yes
checking for getfsstat... no
checking for usleep... yes
checking for setlocale... yes
checking for tcgetattr... yes
checking for if_nameindex... yes
checking for if_freenameindex... yes
checking for getpagesize... yes
checking for dlopen... yes
checking for mkstemp... yes
checking for getpwnam... yes
checking for getgrnam... yes
checking for setgid... yes
checking for setuid... yes
checking for setgroups... yes
checking for setitimer... yes
checking for SIOCGIFADDR in sys/ioctl.h... yes
checking for two-argument statfs with struct fs_data (Ultrix)... no
checking if __FUNCTION__ is defined... yes
checking for sigaction.sa_sigaction... yes
checking for sockaddr.sa_len... no
checking for sockaddr.sa_union.sa_generic.sa_family2... no
checking for rtentry.rt_dst... yes
checking type of rtentry structure... Unknown
unknown
checking for struct rtentry... rtentry
checking for rtentry.rt_unit... no
checking for rtentry.rt_refcnt... no
checking for rtentry.rt_hash... no
checking for rtentry.rt_use... no
checking for tcpstat.tcp_rcvmemdrop... no
checking for ifnet.if_mtu... no
checking if _KERNEL needs to be defined for if_mtu... no
checking for ifaddr.ifa_next... yes
checking for ifnet.if_baudrate... no
checking for ifnet.if_baudrate.ifs_value... no
checking for ifnet.if_speed... yes
checking for ifnet.if_type... yes
checking for ifnet.if_imcasts... no
checking for ifnet.if_iqdrops... yes
checking for ifnet.if_noproto... no
checking for ifnet.if_omcasts... no
checking for ifnet.if_xname... no
checking for ifnet.if_lastchange.tv_sec... no
checking for ifnet.if_obytes... yes
checking for ifnet.if_ibytes... yes
checking for ifnet.if_addrlist... no
checking for ifnet.if_addrhead.tqh_first... no
checking for udpstat.udps_discard... no
checking for udpstat.udps_noport... no
checking for udpstat.udps_noportbcast... no
checking for udpstat.udps_fullsock... no
checking for arphd.at_next... no
checking for swdevt.sw_nblksenabled... no
checking for statvfs.f_frsize... yes
checking for statvfs.f_files... yes
checking for nlist.n_value... no
checking for ipstat.ips_cantforward... no
checking for ipstat.ips_cantfrag... no
checking for ipstat.ips_delivered... no
checking for ipstat.ips_fragdropped... no
checking for ipstat.ips_fragtimeout... no
checking for ipstat.ips_localout... no
checking for ipstat.ips_noproto... no
checking for ipstat.ips_noroute... no
checking for ipstat.ips_odropped... no
checking for ipstat.ips_ofragments... no
checking for ipstat.ips_reassembled... no
checking for des_ks_struct.weak_key... no
configure: warning: Can't check sysctl, manually define CAN_USE_SYSCTL
if platform support available
checking whether TCP timers depend on `hz'... no
checking Default version of SNMP to use... (cached) 2
checking System Contact Information... (cached) root@localhost
checking System Location... (cached) Unknown
checking Location to write logfile... (cached) /var/log/snmpd.log
checking Location to write persistent information... (cached) /var/net-
snmp
updating cache ./config.cache
creating ./config.status
creating Makefile
creating snmplib/Makefile
creating apps/Makefile
creating apps/snmpnetstat/Makefile
creating agent/Makefile
creating agent/helpers/Makefile
creating agent/mibgroup/Makefile
creating local/Makefile
creating testing/Makefile
creating man/Makefile
creating mibs/Makefile
creating net-snmp-config
creating include/net-snmp/net-snmp-config.h
+ make
/opt/eldk/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/../../../../ppc-
linux/bin/ld: cannot open output file .libs/: Is a directorycollect2: ld
returned 1 exit status
make[1]: *** [libnetsnmp.la] Error 1
make: *** [subdirs] Error 1
error: Bad exit status from /opt/eldk/var/tmp/rpm-tmp.96354 (%build)


RPM build errors:
    Bad exit status from /opt/eldk/var/tmp/rpm-tmp.96354 (%build)
