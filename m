Message-ID: <3D4FEA26.1070403@elsoft.ch>
Date: Tue, 06 Aug 2002 17:24:22 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with bk repository?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

In the last few days and weeks, i'm seeing in increasing number of
errors like this:

david@devil:/repository/linuxppc_2_4_devel>bk parent
Parent repository is bk://ppc.bkbits.net/linuxppc_2_4_devel
david@devil:/repository/linuxppc_2_4_devel>bk pull -ll
ERROR-Can't get read lock on the repository.
pull: remote locked, trying again...
ERROR-Can't get read lock on the repository.
pull: remote locked, trying again...
ERROR-Can't get read lock on the repository.
pull: remote locked, trying again...
ERROR-Can't get read lock on the repository.
pull: remote locked, trying again...


Is this something to worry about or just some kind of "bandwidth
limitation"?


Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
