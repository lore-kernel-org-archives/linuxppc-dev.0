Message-ID: <3CBD342C.4090309@bluewin.ch>
Date: Wed, 17 Apr 2002 10:37:00 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: srinivas pulipati <srinivasp@multitech.co.in>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: rtlinux interrupt response
References: <3CBD2584.B1504DA5@multitech.co.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 04/17/2002 09:34 AM, srinivas pulipati wrote:

>hi all,
>
>i have downloaded denx rtlinux and ported it to my custom board for
>study purpose.
>my board is based on MPC860. rtlinux is working fine.
>

This is off topic here. Very likely you get better help from the
rtlinux.org or rtai.org mailing lists.

>
>
>i tried to measure the interrupt response time.
>i am getting best case is 30microseconds and worst case is
>150microsenconds.
>couldn't understand why this much difference.
>can anybody explain? or is there any thing wrong in my port?
>

With RTAI I measured sometime ago on a TQM860L, 50MHz,
8KB data cache:

                             Min     Max     Average:

  No load                :   13us    46us    14us

  while : ; do a=a ; done:   13us    46us    18us

  ping -f to target      :   13us    46us    19us


If I remember correctly, rtlinux has bigger overhead (more code).

BTW: Denx has dropped support for rtlinux quite a while ago
because of fsmlabs license policy (AFAIK, there is no open rtlinux
for the MPC 8xx).

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
