From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
Date: Wed, 13 Feb 2002 23:19:36 +0100
Message-Id: <20020213221936.26316@smtp.wanadoo.fr>
In-Reply-To: <87ofitf488.fsf@theorie.physik.uni-muenchen.de>
References: <87ofitf488.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Which consumes unnecassary power, reducing battery life.  I see the
>point.  Would it make sense to make the time between the link going
>down and the device powering off configurable, either as a module
>parameter or as a kernel config option?  Then one could choose to have
>either sensible power management or automatic link detection, if it's
>not possible to get both.

In that case, there is no need to configure the delay. If we go that
way, I can make sure the device gets powered back up on the ioctls,
those will keep the chip up. So either you use ifd and keep the interface
powered, or you dont. I have to think a bit more about this though.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
