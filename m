Message-ID: <387D7DD5.DA4B1A68@cns.canon.co.jp>
Date: Thu, 13 Jan 2000 16:25:09 +0900
From: Ouchi Masatomo <oouchi@cns.canon.co.jp>
Reply-To: oouchi@cns.canon.co.jp
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
CC: oouchi@cns.canon.co.jp
Subject: Re: LinuxPPC Embedded: root nfs boot problems.
References: <382BC9B2.FDF9AD50@ctam.com.au> <382BE502.4CFC93BD@enib.fr> <382F4582.4F6882F2@ctam.com.au>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Please help me.

[used source]
  mpc8xx-2.2.13
  I am trying to boot by NFS.

[NFS Server]
  Linux  2.2.5-15 for i686 by Redhat ver 6.0
  IP=192.168.0.254
  defines client's name, MAC, IP, ... in /etc/bootbtab

[status]
  I met following console messages,

*************************************************
  ...
  eth0: CPM ENET Version 0.2, 00:00:85:30:30:31
  Sending BOOTP and RARP requests.... OK
  IP-Config: Got BOOTP answer from 192.168.0.254,
       my address is 192.168.0.100
  Looking up port of RPC 100003/2 on 192.168.0.254
  Looking up port of RPC 100005/1 on 192.168.0.254
  VFS: Mounted root (NFS filesystem) readonly.
  Freeing unused kernel memory: 40k init
  nfs: server 192.168.0.254 not responding, still trying
  nfs: server 192.168.0.254 OK
  nfs: server 192.168.0.254 not responding, still trying
  nfs: task 20 can't get a request slot
  nfs: server 192.168.0.254 OK
  neighbour table overflow
  ...
*************************************************

[NFS servers's /var/log/messages says]
  bootpd[880]: version 2.4.3
  mountd[520]: authenticated mount request from mpc860ads:800


<<Question>>
 What is wrong with my setting?
--
 oouchi@cns.canon.co.jp

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
