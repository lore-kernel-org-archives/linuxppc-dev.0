Date: Thu, 27 Sep 2001 16:33:20 +0900 (JST)
Message-Id: <20010927.163320.846962931.t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: broken symlinks
From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

Recentry I updated my kernel from 2.4.10-pre12 to 2.4.10.
Kernel sources are get from linuxppc_2_4_devel.

Since updated to 2.4.10, it is sometimes occurd that broken symlinks
are made. It seems to be occured only when making symlinks via NFS.
(The kernel version of NFS server is 2.4.10 from linuxppc_2_4_devel.)



Here is an expamle of broken symlink.


$ df /work
Filesystem           1k-blocks      Used Available Use% Mounted on
foo:/work            5910464   1883320   3726912  34% /work
$ pwd
/work/redhar/BUILD/qt-2.3.1/include
$ ls -l qdatetm.h
lrwxrwxrwx    1 t-matsuu kagaku        343 Sep 27 15:43 qdatetm.h -> /work/redhat/BUILD/qt-2.3.1/src/compat/qdatetm.hP4Bj 3CLS)
	-rm -f *~ core
	-rm -f allmoc.cpp

####### Extension Modules

listpromodules:
	@echo

listallmodules:
	@echo

listaddonpromodules:
	@echo

listaddonentmodules:
	@echo


REQUIRES=large-config

####### Sub-libraries


###### Combined headers



####### Compile

main.o: main.cpp


MATSUURA Takanori @ Division of Protein Chemistry,
                     Institute for Protein Research, Osaka University, Japan
E-Mail: t-matsuu@protein.osaka-u.ac.jp
Web Page: http://chux1.protein.osaka-u.ac.jp/~t-matsuu/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
