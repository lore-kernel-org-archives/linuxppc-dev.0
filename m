Date: Sat, 28 Apr 2001 00:59:01 -0700
Subject: Re: After mount nfs root filesystem,can't execute /bin/sh.
From: Karsten Jeppesen <kj-list@jeppesens.com>
To: <zjuzhou@163.net>, <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B70FC655.6B3F%kj-list@jeppesens.com>
In-Reply-To: <3AEA3CE5.06115@bjapp3>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is root mounted RW?

Also:

There are debug flags to nfsd which will allow you to see what is loaded and
if not then why not.
usually: rpc.nfsd -D call
But it differs



Sincerely,

Dr. Karsten Jeppesen
VP of Technology
Total Impact
<kj@totalimpact.com>
----------------------------------------------------------------------
There's so much plastic in this culture that vinyl leopard skin is
becoming an endangered synthetic.
----------------------------------------------------------------------
> From: zjuzhou@163.net
> Date: Sat, 28 Apr 2001 11:45:41 +0800 (CST)
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: After mount nfs root filesystem,can't execute /bin/sh.
>
>
> hello all:
> i use hhl2.2.14 kerlner for RPXLite borad,i have porting it to my borad.
> But when i boot use nfs as root filesystem,it always can't run .I use
> /opt/hardhat/devkit/ppc/8xx/target/ as nfs exports,and this is created from
> cdk1.2 for Linuxplant(i think this files is same as RPXlite's).
>
>
> in main.c
>
> execev("/sbin/init",argv_init,envp_init) /***it run here ,system is halt**/
> execev("/bin/sh",argv_init.envp_init) /***it also halt*******/
>
>
> Who can help me,thanks.
> Dross Chou.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
