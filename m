From: "labblelabble" <labblelabble@hotmail.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: how to write my own keyboard module
Date: Tue, 23 Dec 2003 16:19:52 +0800
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <BAY8-DAV441oXNIfFsf00011065@hotmail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello:
    I must add a new keyboard module to my own system ,and then i will try
to explain my system in details .My system use the IBM powerpc 823e cpu,and
the linux kernel is the Montivista hardhar linux 2.4.18_mv130. I have read
some books about linux driver module,and the powerpc 823 user manul. and my
keyboard signals are directly connected to powerpc 823 IPB0_IPB7 pins, so I
want to poll the keyboard device .How can i do it ? Use the tasklet ,kernel
timer,t_quenes or use the mpc 823 CPM timers interrupt.And another question
,I read the sourcecodes of linux and i know the part which is responsible
for the system times according to the 823 reatime timer and periodic
interrupt timer ,but if there is some module used to manage the 823CPM
timers ,and if there is some function interfaces provided by the kernel for
powrpc can be used.maybe the useage of the 823 cpm timers is just the
interrupt management of the kernel...so wish someone could give me some hint
about my problems ....

Merry Christamas!!!!!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
