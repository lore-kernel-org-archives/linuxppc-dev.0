Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <6213bc560905242330j31c14d22pabb67174e105d68c@mail.gmail.com>
References: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
	<20090519235302.GA6333@yookeroo.seuss>
	<6213bc560905192250w4caa84aem9c0dedb2eed72fea@mail.gmail.com>
	<6213bc560905242330j31c14d22pabb67174e105d68c@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 00:39:16 -0600
Message-ID: <fa686aa40905242339l51ee5656ue388cde6da253287@mail.gmail.com>
Subject: Re: Initialize DBCR0 for PPC440 targets
To: srikanth krishnakar <skrishnakar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 12:30 AM, srikanth krishnakar
<skrishnakar@gmail.com> wrote:
> Hello Grant,
>
> Is there any conclusion of the below discussion:
>
> http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td23049044.html
>
> Xilinx target (virtex5) hangs (while running GDBServer & KGDB) without
> the DBCR0 initialization.
>
> Can you please comment on this ?

IIRC, John Linn was hacking on a patch.  Search the mailing list
archives for DBCR0.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
