Message-ID: <3AB6ABF6.253DFF8D@intrex.net>
Date: Mon, 19 Mar 2001 20:01:42 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>, blythe@routefree.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM405 gp walnut
References: <200103191113.GAA58475@p2.parker.boston.ma.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brad,

Well it was endian problems.  I ran an mp3 to wav conversion that sox
recomended.  I then had to do a word swap on the 16 bit data and it
sounded fine.  Is there anyway to tell the driver that the samples are
byte reversed?

Chip


Brad Parker wrote:

> Ralph Blach wrote:
> >Brad,
> >
> >I got the same results with mad play, but 16 bit sound sounds terrible
> >Try using mpg123 and sox to convert
> >to a wav file and then try it.  I think it has endian problems.
>
> thanks - I will.  I looked into that for a few minutes a few weeks ago
> and didn't see anything obvious;  I'll take another look.
>
> -brad

--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
