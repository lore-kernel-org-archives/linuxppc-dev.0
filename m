To: "Wolfgang Denk" <wd@denx.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
References: <20040719205835.AA851C109F@atlas.denx.de>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Mon, 19 Jul 2004 21:38:27 -0400
In-Reply-To: <20040719205835.AA851C109F@atlas.denx.de> (Wolfgang Denk's
 message of "Mon, 19 Jul 2004 16:58:30 -0400")
Message-ID: <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 19 Jul 2004, wd@denx.de wrote:

> And as usual, there is two sides to initramfs. It may be convenient
> for some cases, where you can use the very same root filesystem
> image bundled with the kernel image, but exactly thsi convenience
> may hurt you in other cases where it's much better when you have
> separated images which can be updated independently of each other.

Maybe I missed some thing but:

        - I'm using initramfs in my current project (2.6.7)
        - I failed to see what in initramfs mechanism would prevent
          one from having "separated images which can be updated
          independently of each other."


Regards
--
L.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
