Message-ID: <40740181.6000603@bluewin.ch>
Date: Wed, 07 Apr 2004 15:26:25 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: =?windows-1252?Q?=3F=3F=3F?= <willy@airpoint.co.kr>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems of kernel-2.6.4 for mpc8260
References: <00c001c41c75$29e6cf00$21589edd@sonyvaior505>
Content-Type: text/plain; charset=windows-1252
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 04/07/2004 09:51 AM ??? wrote:
> I got succeeded to port kernel 2.6.4 to out custom MPC8260 board with
> the help of DENX ELDK 3.0 tool. Thanks!! But there is some problems to
> be solved.
>
> After booting, when I try to install module, following error occured.
>
>       bash-2.05b# insmod dsrc_drv.o
>       insmod: QM_MODULES: Function not implemented

Module support seems not to be enabled in your kernel.

>
>       bash-2.05b# insmod -V
>       insmod version 2.4.22
>
> As you can see above, the version of modutils seems to be fine. right?
> If so, what's the reason of above error? And one more problem. At boot
> sequence(as following) lots of unexpected 'modprobe: xxx' messages are
> issued.
>
>      VFS: Mounted root (nfs filesystem).
>      Freeing unused kernel memory: 84k init
>      INIT: version 2.84 booting
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>                      Welcome to DENX Embedded Linux Environment
>                      Press 'I' to enter interactive startup.
>      Building the cache nfs_refresh_inode: inode number mismatch expected (0:b/0x169e8f), got (0:b/0x169e90)
>      nfs_refresh_inode: inode number mismatch expected (0:b/0x169e8f), got (0:b/0x169e90)
>      [  OK  ]
>      Mounting proc filesystem:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Configuring kernel parameters:  [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Cannot access the Hardware Clock via any known method.
>      Use the --debug option to see the details of our search for an access method.
>      Setting clock : Wed Dec 31 19:00:14 EST 1969 [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Setting hostname WillyHat:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Activating swap partitions:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      Checking filesystems
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      Mounting local filesystems:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>                  Enabling swap space:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Entering non-interactive startup
>      modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      Setting network parameters:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>      [  OK  ]
>      Bringing up loopback interface:  modprobe: Can't open dependencies file /lib/modules/2.6.4/modules.dep (No such file or directory)
>
> How can I fix these problems?

See above. Furthermore the module dependency file may not be correct for
your arch.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
