Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <bart@ardistech.com>
Cc: "Stephan Linke" <Stephan.Linke@epygi.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 15:10:35 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLGEBAFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3DA6CA28.4F84FDFB@ardistech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
>
> > Look in cpm_iic_read() for:
> > /* flush will invalidate too. */
> > flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));
> >
> > You can't just do invalidate_dcache_range() since it will invalidate more than your buffer
> >
> In my case it did invalidate the stack :(

Me too, it was a major PITA to hunt it down.

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
