Message-ID: <3FD8AB14.8050307@kegel.com>
Date: Thu, 11 Dec 2003 09:36:20 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: AlessandroPPC <aleppcrossi@libero.it>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: R: self image
References: <20031210210608.03D20C5F5F@atlas.denx.de> <006601c3c00b$1eefa160$0400a8c0@eurostudio.local>
In-Reply-To: <006601c3c00b$1eefa160$0400a8c0@eurostudio.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


AlessandroPPC wrote:
> Just one more question: when I add the "top" program (and related library)
> to the filesystem, and I try to run it, the following message appears before
> exit:
>
> top: Unknown terminal "xterm" in $TERM
>
> Any idea how to solve it?

You need /usr/share/terminfo/x/xterm, I think.
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
