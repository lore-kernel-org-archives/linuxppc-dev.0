From: deepesh@india.tejasnetworks.com
Date: Tue, 12 Nov 2002 09:23:26 +0530 (IST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Cache Enabling
Message-ID: <Pine.LNX.4.21.0211120922040.19036-100000@deepesh.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had enabled the Data Cache. I forgot to mention that.

Deepesh




On Mon, 11 Nov 2002 deepesh@india.tejasnetworks.com wrote:

>
>
> Dear All,
>
>
> I am using Power PC. The system which I am using takes 2 minutes more than
> usual for the software in the system to come up without cache
> enabling. These 2 minutes are really crucial.
> But there are problems when I enabled cache. The devices which I am using
> are mmapped. I do not want cache to be enabled for the memory mapped
> devices. When cache is enabled, none of the mmapped devices work in the
> usual way. How do I selectively disable the cache for the mmapped devices?
>
>
> Thank you,
> Deepesh
>
>

--

D.Deepesh
R&D Engineer,
Tejas Networks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
