Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Stephan Linke" <Stephan.Linke@epygi.de>, <bart@ardistech.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 14:46:12 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLIEAPFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <FCEAKDJJAPHPLJFINDAJMENOCJAA.Stephan.Linke@epygi.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
> Hi Bart and Joakim,
>
> Well. No, I'm not shure. But I see what you mean Bart. :) I'll see what
> happens now.
>
> And I have a question to Joakim. In your code you wrote (cpm_iic_init):
>
> 	i2c->i2c_i2mod = 0x80; /* Filter clock */
>
> I think this is not what you intended. I didn't find that bit (bit 0) in my
> 862 manual. But there's the FLT flag (bit 4) that matches your comment. So I
> think It should be:
>
> 	i2c->i2c_i2mod = 0x08; /* Filter clock */

You are right

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
