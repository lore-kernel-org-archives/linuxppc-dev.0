Message-ID: <3AB10B99.B5C43C07@mvista.com>
Date: Thu, 15 Mar 2001 11:36:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: =?iso-8859-1?Q?Bj=F6rn?= Wingman <bjowi@ida.liu.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mcpn765
References: <yx2r8zzghpd.fsf@aste15.ida.liu.se> <3AB0EA13.B893E257@mvista.com> <200103151827.TAA26091@aste15.ida.liu.se>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Björn Wingman wrote:

> > I take it you're using the code in the linuxppc_2_5 right?
>
> No. I pulled the sources with
>
> bk clone bk://bitkeeper.fsmlabs.com:5005 linux_2_5
>
> as some earlier mail said, but it seems to be incomplete. Several
> directories, like kernel and mm are empty. Am I supposed to merge this
> tree with the latest 2.4-tree somehow?

No.  Sounds like you need to do a "bk pull" and "bk -r get" in your local
repository.


> Is there an FAQ somewhere that I
> haven't found?

Its very simple an no different from most other boards.

bk pull
bk -r get
edit your Makefile to run the proper tools and use the correct arch.
make mcpn765_config
make config (or whatever)
make dep clean zImage
you kernel will be in arch/ppc/boot/images/zImage.pp3

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
