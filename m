In-Reply-To: <Pine.A41.4.05.9908271508310.19776-100000@c2.hrz.uni-giessen.de>
Date: Fri, 27 Aug 1999 22:28:24 +0200
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bug in l2cr status display?
Message-Id: <19990827222824.024086@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 27, 1999, Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de> wrote:

>It seems to me, that the L2CR programming is implemented but disabled in
>current kernel version. The L2CR=xxxxxxx doesn't work for me.

We didn't add the call to setup_l2cr when merging 2.2 with Linus to avoid
changing non-arch stuffs late during the merge, things were already
complicated enough. In the meantime, I used a different solution via a
property stuck by BootX in the device tree, but this is really broken in
several ways, and we should put back the l2cr=xxxx option once for all now.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
