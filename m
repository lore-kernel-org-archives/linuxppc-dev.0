Message-ID: <3CC550C8.F7AB6F1A@imc-berlin.de>
Date: Tue, 23 Apr 2002 14:17:12 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Thomas Lange <thomas@corelatus.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx IDMA and console garbage
References: <3CC5477E.4955821A@imc-berlin.de> <3CC54AC4.49A243C9@corelatus.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thomas Lange wrote:
>
> I also played around with IDMA and noticed the
> same thing.
>
> Serial works ok if you put idma priority below
> SMC priority. Never investigated further...

Thanks a million.

That helped. But why? :-(

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
