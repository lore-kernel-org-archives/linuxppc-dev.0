Message-ID: <4051B5EA.4030502@g-house.de>
Date: Fri, 12 Mar 2004 14:06:50 +0100
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to get the exact source code from this clone of linux tree:bitkeeper
References: <001b01c40802$ea7e2970$3401080a@telxsi.com>
In-Reply-To: <001b01c40802$ea7e2970$3401080a@telxsi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


challaharikumar wrote:
> How to get the exact source code from this clone of linux tree.. Any help
> would be highly appreciated

i myself was once asking this on this list and i was told to do:

$ bk clone bk://source.mvista.com/linuxppc-2.5-benh linuxppc-2.5-benh-BK

(to fetch the linuxppc-2.5-benh tree and store it into
./linuxppc-2.5-benh-BK )

and then

$ cd linuxppc-2.5-benh-BK
$ bk -r get

although i always thought "clone" would really "clone" the tree itself...

cheers,
Christian.
--
BOFH excuse #59:

failed trials, system needs redesigned

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
