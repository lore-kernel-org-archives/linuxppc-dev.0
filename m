Message-ID: <3CFB06F3.6060704@pacbell.net>
Date: Sun, 02 Jun 2002 23:04:35 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:
> Is anyone prepared to speak up for the dbcr0 and dbcr1 fields that
> someone added to struct pt_regs for 4xx in the 2_4_devel tree?
>
> If not, they are going.  If so, we can discuss it.
>
> Better still, does anyone have a clearly thought-out vision of how the
> debug facilities on 4xx should be managed?
>
> I would much prefer to see these fields put in the thread_struct
> rather than pt_regs.  I am reluctant to change pt_regs without a good
> reason since it is visible to userspace and is therefore part of the
> kernel API.  If the intention is to make the debug facilities
> available to userspace then the thread_struct is a good place to put
> fields relating to the debug facilities.
>
> Paul.
>
>
>
>
>

Oh man its been a while... hmmm IIRC I thought we used pt_regs for kgdb.
  IIRC we already use the thread_struct for gdb.  There are two people
who did the bulk of the debugger work, if they don't pipe up , I will do
my best.

I'll get back to you.

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
