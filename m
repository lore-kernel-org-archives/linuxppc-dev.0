Message-ID: <20000130063758.27283.qmail@web3006.mail.yahoo.com>
Date: Sat, 29 Jan 2000 22:37:58 -0800 (PST)
From: Wang Yong <wung_y@yahoo.com>
Subject: Re: Looking for a better debug tool for embed-environment...
To: dony <dony.he@huawei.com.cn>, Jesper Skov <jskov@redhat.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



why not try DDD(data display debugger). the debuger
engine is gdb but it has a friendly GUI and easier to
use. remember to configure it to use the xgdb.

w.y.

--- dony <dony.he@huawei.com.cn> wrote:
>
> Hi,
>     Now I am looking for a friendly GUI debug tool
> for our
> embed-linux-environment.
>    Do you know other debug tools which can be used
> in embed-environment?
>     The "gdbserver" and "powerpc-linux-gdb" are not
> friendly for debug,
> especially in a large project.
>
>       Dony
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
