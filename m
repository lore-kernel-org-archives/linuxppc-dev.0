Date: Sat, 19 Apr 2003 17:23:57 +0200
From: "K.G." <k_guillaume@libertysurf.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Important Bugfixes for HFS+ resize _DON'T USE THE 4TH PATCH TO RESIZE HFS+_ (use the 5th)
Message-Id: <20030419172357.5ca0deb5.k_guillaume@libertysurf.fr>
In-Reply-To: <20030417193624.64a7954a.k_guillaume@libertysurf.fr>
References: <20030417193624.64a7954a.k_guillaume@libertysurf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Apr 2003 19:36:24 +0200
K.G. <k_guillaume@libertysurf.fr> wrote:

> Hi,
>
> Here is my last patch against parted 1.6.5, to provide HFS and HFS+ support for it :
>
> http://xilun666.free.fr/parted-1.6.5-hfs-4.patch
>
> It includes :
> 	memory leaks removal, code cleanups, resize hfs+ code,
> 	more checks, minor hfs resize bugfix, probe code returns real geometry,
> and still all features of the third (same address, s/-4/-3/) patch.
>
> If you want to try it you should save your important data.
> You may want to run hpfsck or the Apple Sos Disk util too, before and after running parted with this patch.
> Please also report me success or failure, as well as messages from fsck utils.
>
> Enjoy !
>
> ---
> Guillaume Knispel

This patch had 3 important bugs that could result in data corruption both in FS and in user's files.
_DON'T USE IT TO RESIZE HFS+_
The following patch correct that :

http://xilun666.free.fr/parted-1.6.5-hfs-5.patch

I suggest you continue saving your important data ! :)

---
Guillaume Knispel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
