Message-ID: <3BF0AED8.1020503@embeddededge.com>
Date: Tue, 13 Nov 2001 00:25:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE in Mode 1 (Sandpoint) how ?
References: <20011113040707.18867.qmail@mailweb26.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:


> ..... But whatss troubling
> my head is, the kernel boots up fine until the NFS mount.
> Had the switch settings been wrong, the serial output
> would be slow from early bootup, right ?

Nope.  All of the kernel print out is polled I/O.

> .....  But thats
> not the case. Why should it be slow after INIT starts
> up ?

Because it uses interrupt driven serial I/O.

Believe me, all of us using Sandpoints have seen this before.
Your interrupt/arbitration routing switches on the board are wrong.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
