Message-ID: <CA78D1B723D8D411AF0300508BDCF74F8C0FE2@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Out of memory ?
Date: Wed, 30 Jan 2002 15:58:07 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi all,

  I have a custom board based in the MPC823e.
  I am using mvista ftpserver who works OK in the FADS but, when i try to do
it in my custom board it says that it is out of memory. But with the meminfo
it says that i have memory.

  Can anybody help me?
  Thanks in advance


  # cat meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:   6381568  2576384  3805184  1208320  1048576   593920
Swap:        0        0        0
MemTotal:         6232 kB
MemFree:          3716 kB
MemShared:        1180 kB
Buffers:          1024 kB
Cached:            580 kB
Active:           1604 kB
Inact_dirty:         0 kB
Inact_clean:         0 kB
Inact_target:       24 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         6232 kB
LowFree:          3716 kB
SwapTotal:           0 kB
SwapFree:            0 kB




# chroot /nfs/CNC8055_FTPSERVER/


BusyBox v0.60.0 (2001.09.18-16:26+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# inetd -d
ADD : echo proto=tcp, wait.max=0.40, user.group=root.(null) builtin=100141dc
server=internal
ADD : echo proto=udp, wait.max=0.40, user.group=root.(null) builtin=100141ec
server=internal
ADD : discard proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=100141fc server=internal
ADD : discard proto=udp, wait.max=0.40, user.group=root.(null)
builtin=1001420c server=internal
ADD : daytime proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=1001423c server=internal
ADD : daytime proto=udp, wait.max=0.40, user.group=root.(null)
builtin=1001424c server=internal
ADD : chargen proto=tcp, wait.max=0.40, user.group=root.(null)
builtin=1001425c server=internal
ADD : chargen proto=udp, wait.max=0.40, user.group=root.(null)
builtin=1001426c server=internal
ADD : ftp proto=tcp, wait.max=0.40, user.group=root.(null) builtin=0
server=/bin/ftpd
someone wants ftp
accept, ctrl 3
kmod: runaway modprobe loop assumed and stopped
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 29 (inetd).
Out of Memory: Killed process 30 (inetd).
request_module[net-pf-1]: waitpid(31,...) failed, errno 1
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).
Out of Memory: Killed process 30 (inetd).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
