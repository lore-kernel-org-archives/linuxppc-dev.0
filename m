Message-ID: <20000120131307.13948.qmail@web3003.mail.yahoo.com>
Date: Thu, 20 Jan 2000 05:13:07 -0800 (PST)
From: Wang Yong <wung_y@yahoo.com>
Subject: Re: unknown protocol icmp
To: szg98@mail.zte.com.cn, linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you must forget /etc/protocols so that
getprotobynamereturns fail

w.y.

--- szg98@mail.zte.com.cn wrote:
>
>
>
>
>
> Hi,all
>      I modified mpc8xx-2.2.13 for my custom
> XPC860ENZP50C1 board.
> Now it can boot to prompt "init-2.0#" from nfs
> server.
> Every thing seems okey but network.
>
>      init-2.0# ping <my nfs server ip>
>      ping: unknown protocol icmp
>      init-2.0# telnet <my nfs server ip>
>      telnet:unknown services ...
>
> What's the problem?
> Thanks for your time.
>
> szg98@mail.zhongxing.com
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
