Date: Wed, 17 Sep 2003 12:11:31 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: kernel config & nfs (maybe!!)
In-reply-to: <3F6778D0.1010700@tait.co.nz>
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F67A6B3.7010405@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <3F6778D0.1010700@tait.co.nz>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Never mind!!

Turned out to be the /dev directory in the host copy of the root fs
didn't have all the special files in it that it should have had so I was
unable to execute the init task once the root nfs mount was done.

Robin Gilks wrote:
>
> Greetings
>
> I might be missing something here with nfsroot, kernel config & the
> kernel command line but...
>
> When one does a "make oldconfig", is there a way to stop it asserting
> the lockd config if nfs is enabled? Its driving me nuts trying to do an
> automated build of a kernel that doesn't require a local rpc server to
> do the locking and since I want to boot with a nfsroot filesystem, I
> can't see how to get the -o nolock across the kernel command line.
>


--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
