Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: WRITE_THRU  on 8xx missing
Date: Thu, 5 Sep 2002 00:27:10 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLMEDAFGAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <IGEFJKJNHJDCBKALBJLLGECHFGAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just noticed that _PAGE_WRITETHRU is defined in the linuxppc_2_4 tree but not in
the linuxppc_2_4_devel tree, which is the one I am using :-(. Has this "function" been removed ,
never to return or is the devel tree in a flux now for mpc8xx?

If it has been removed, please reconsider adding it again. Now that burstable flash devices are
common and there is a flash based FS(JFFS2) in the kernel, I think there will be a need for
this functionality.

     Joakim

>
>
> I am trying to create a cached memory mapping which is in WRITETHRU using ioremap().
> But in the latest PPC kernel for a mpc8xx target there is no flag for WRITETHRU (_PAGE_WRITETHRU).
>
> Why is it gone? Is there a replacement flag?
> I want to use this mapping to do burst reads but single writes for a flash device.
>
>  Joakim
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
