Date: Tue, 24 Feb 2004 12:46:48 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone using uClibc on a 405GP platform?
Message-ID: <20040224114648.GC2970@tmathiasen>
References: <20040224110901.GB2970@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040224110901.GB2970@tmathiasen>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 24 2004, Torben Mathiasen wrote:
>
> Hi,
>
> Does anyone successfully use uClibc on a 405GP platform? I tried compiling
> uClibc but all my dynamic apps just segfault. Its the shared library loader
> that segfaults immediately after execve(). I tried both a recent 2.4 and 2.6
> kernel with the same result. Also using latest 0.9.26 uClibc.
>
> Has anyone gotten this to work?
>

Funny, I got this to work. I was under the assumption that one should be able
to execute the library loader directly, which has never worked for me on
powerpc. But a dynamic linked application seems to be working now. Both those
I compiled myself and the ones I got from the root_fs_powerpc fs.

Torben
--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
