Message-ID: <399C3BB1.73929509@execpc.com>
Date: Thu, 17 Aug 2000 14:23:29 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Vladimir Simonov <sv@asplinux.ru>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Can't find nvtool?
References: <NEBBKFDEKEFCPABJIFOMKEEFDEAA.sv@sw.mipt.ru> <399C396E.C72DFCA4@execpc.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


after actually looking at the code, theres an ioctl for /dev/nvram for locating
the 3 partitions, calling a function in pmac_support.c

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
