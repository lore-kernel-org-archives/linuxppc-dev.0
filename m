From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15900.45086.608629.636148@argo.ozlabs.ibm.com>
Date: Thu, 9 Jan 2003 10:11:26 +1100
To: mlan@cpu.lu
Cc: panto@intracom.gr, linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
In-Reply-To: <E18WOU9-00009Z-00@piglet.grunz.lu>
References: <3E1BECD2.9060909@intracom.gr>
	<E18WOU9-00009Z-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> Tried to compile my standard kernel compile a while back, and found the
> following things broken (didn't have time to try fixing yet...):
>
> - 53c94 Mac SCSI

I just pushed a fix (untested) for mac53c94 scsi to linuxppc-2.5.
If you try it out, let me know how it goes.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
