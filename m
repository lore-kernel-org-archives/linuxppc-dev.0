From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gwyn Judd <b.judd@xtra.co.nz>,
        LinuxPPC Developers List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.18-pre17 woes (COMPAQ_CISS_MAJOR undefined)
Date: Mon, 23 Oct 2000 15:55:54 +0200
Message-Id: <19340917072738.15133@192.168.1.2>
In-Reply-To: <20001024021816.A2578@thislove>
References: <20001024021816.A2578@thislove>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I don't even have this driver enabled. Anyone else get this? Also when I
>switched to the cvs tree on ppc.samba.org (I think) for the last month
>or so I wasn't getting any updates until only today. I guess whatever
>was wrong they have fixed anyway.

The rsync trees moved to penguinppc.org (for bandwidth issues).

Paulus trees:

  penguinppc.org::linux-pmac-stable
  penguinppc.org::linux-pmac-devel

My tree:

  penguinppc.org::linux-pmac-benh

The 2.2.18pre17 I pushed to linux-pmac-benh yesterday compiles fine.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
