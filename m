Date: Wed, 19 Sep 2001 14:58:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10-pre12 sysrq.c compile error
Message-ID: <20010919145836.A25452@mikef-linux.matchmail.com>
References: <p0433010bb7cebf4c3df9@[63.220.231.138]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p0433010bb7cebf4c3df9@[63.220.231.138]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 19, 2001 at 05:34:26PM -0400, Stefan Jeglinski wrote:
>
> rsynced mvista today, linuxppc_2_4:
>
> sysrq.c:35: conflicting types for `wakeup_bdflush'
> /usr/src/linuxppc_2_4/include/linux/fs.h:1347: previous declaration
> of `wakeup_bdflush'
> make[3]: *** [sysrq.o] Error 1
> make[3]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linuxppc_2_4/drivers/char'
> make[1]: *** [_subdir_char] Error 2
> make[1]: Leaving directory `/usr/src/linuxppc_2_4/drivers'
> make: *** [_dir_drivers] Error 2
>
>
> Help?

If you look at sysrq.c you'll probably find wakeup_bdflush defined twice
with different types.

Please port compiler version, etc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
