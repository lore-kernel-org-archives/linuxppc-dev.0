Date: Thu, 8 Jul 1999 08:49:30 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
In-Reply-To: <37848F6D.5E2437EE@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.9907080848150.25987-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I added lots of printk's to mediabay.c, and apparently the panic occurs at (or
> near) line 276 in media_bay_task:
> 
> if (bay->cd_timer && (--bay->cd_timer == 0 || MB_IDE_READY(i))
                        ^^
>     && bay->cd_index < 0) {

i'm probably way off, but should the decrement be after the cd timer? i
wouldn't think you would want to do math on that pointer in that way.

dave


-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231

When they took the Fourth Amendment, I was quiet because I didn't deal drugs.
When they took the Sixth Amendment, I was quiet because I was innocent.
When they took the Second Amendment, I was quiet because I didn't own a gun.
Now they've taken the First Amendment and I can't say anything.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
