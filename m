In-Reply-To: <199904281409.QAA01267@arda.frodo.local>
Date: Wed, 28 Apr 1999 19:27:35 +0200
To: Frodo Looijaard <frodol@dds.nl>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Support for Hydra i2c
Message-Id: <19990428192735.002083@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 28, 1999, Frodo Looijaard <frodol@dds.nl> wrote:

>This was a very Intel-centered program :=). On Intel PCs, we often have
>some hardware sensors attached to the ISA bus. We will have to find out
>whether this is the case with PPCs too.

On non-CHRP PowerMacs, there is at least one I2C bus (maybe more) driven
by Cuda. It's used for things like planB video input, and maybe some more
stuffs. Unfortunately, I think we only know how to write to the i2c bus.
More hacking needed before we can implement this one too.
 

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@misys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
