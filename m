Date: Thu, 28 Jun 2001 22:45:07 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: addresses in xmon trace output?
Message-ID: <20010628224507.B15777@svana.org>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010628120346.A627@wibble.net> <20010628093849.893@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010628093849.893@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Thu, Jun 28, 2001 at 11:38:49AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 28, 2001 at 11:38:49AM +0200, Benjamin Herrenschmidt wrote:
> Paulus helped me fix a bug in the wakup code that could cause
> the kernel MMU mappings to be trashed (VSIDs initialized
> incorrectly) leading to all sort of crashes on wakeup and
> possibly bogus xmon output.
>
> If you resync the tree, you should get the fix.

thanks, paulus told me what to change in sleep.S a few hours ago. I will
rsync again sometime tomorrow probably.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
